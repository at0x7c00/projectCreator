package com.lenovots.crm.project.action;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.persistence.Column;
import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Alignment;
import jxl.write.Border;
import jxl.write.BorderLineStyle;
import jxl.write.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lenovots.crm.admin.service.IDictionaryDetailService;
import com.lenovots.crm.common.action.BaseAction;
import com.lenovots.crm.common.service.IBaseService;
import com.lenovots.crm.project.entity.Entity;
import com.lenovots.crm.project.entity.EnvironmentVariable;
import com.lenovots.crm.project.entity.Packagee;
import com.lenovots.crm.project.entity.Project;
import com.lenovots.crm.project.entity.Rule;
import com.lenovots.crm.project.service.IEntityService;
import com.lenovots.crm.project.service.IPackageService;
import com.lenovots.crm.project.service.IProjectService;
import com.lenovots.crm.project.service.IRuleService;
import com.lenovots.crm.util.CommonUtil;
import com.lenovots.crm.util.DateUtil;
import com.lenovots.crm.util.ELUtil;
import com.lenovots.crm.util.PropertityUtil;



@Controller("entityAction")
@Scope(value="prototype")
public class EntityAction extends BaseAction<Entity> {
	
	private static final long serialVersionUID = 8856961694147206209L;
	
	private static Logger logger = Logger.getLogger(EntityAction.class);
	@Resource
	private IEntityService entityService;
	@Resource
	private IRuleService ruleService;
	@Resource
	private IPackageService packageService;
	@Resource
	private IProjectService projectService;
	@Column()
	private List<Packagee> parentPacks;
	private List<Project> projectList;
	
	private Entity entity;
	
	private Integer packageId;
	private Integer projectId;
	private Integer ruleId;
	
	//与导入相关的字段开始================================================================
	private Integer checkRepeat=0;
	private String formTimeId;//防止重复提交
	private StringBuffer resultInfo;
	private List<String> validatePropNames;
	private Integer[] optionalIds;
	private Map<String,Entity> existedEntityMap = new HashMap<String, Entity>();
	private String  existedEntityMapKey;
	private File excelFile;
	@Resource
	private IDictionaryDetailService dictionaryDetailService;
	//与导入相关的字段结束================================================================
	
	//与导入相关的代码开始=============================================================================================
	public String importExcelUI() {
		formTimeId = UUID.randomUUID().toString();
		ServletActionContext.getRequest().getSession().setAttribute("formTimeId", formTimeId);
		return SUCCESS;
	}
	
	public String importExcel() throws Exception {
		try{
			String formTimeIdInSession = (String) ServletActionContext.getRequest().getSession().getAttribute("formTimeId");
			if(formTimeIdInSession!=null && formTimeIdInSession.equals(formTimeId)){
				
				long start = System.currentTimeMillis();
				if(checkRepeat==1){
					//初始化需要验证的字段
					initValidateProps();
				}
				int success = importEntityExcel(excelFile);
				long end = System.currentTimeMillis();
				ServletActionContext.getRequest().setAttribute("duration", (end - start)/1000);
				ServletActionContext.getRequest().setAttribute("success", success);
				ServletActionContext.getRequest().setAttribute("total",ServletActionContext.getRequest().getSession().getAttribute("total"));
				ServletActionContext.getRequest().getSession().setAttribute("formTimeId", null);
				ServletActionContext.getRequest().getSession().setAttribute("total", null);
				ServletActionContext.getRequest().getSession().setAttribute("rowCount", null);
			}else{
				msg = "表单重复提交";
			}
		}catch(BiffException e){
			e.printStackTrace();
			msg = "文件格式错误！";
		}
		anyAction="entity";
		op="importReport";    
		return ANYFORWARD;
	}
	
	
	public String codeView(){
		entity = entityService.findById(id);
		Rule rule = ruleService.findById(ruleId);
		setAttribute("rule", rule);
		
		ELUtil elUtil = ELUtil.getInstance();
		elUtil.setAttribute("entity", entity);
		try {
			String currentFileFullPackage = elUtil.parse(rule.getOutputDir());
			String currentFileName = elUtil.parse(rule.getOutputFileName());
			currentFileFullPackage = elUtil.calcuteRelativePath(currentFileFullPackage);
			currentFileFullPackage = currentFileFullPackage.replaceAll("/", ".");
			currentFileFullPackage = currentFileFullPackage.replaceAll("\\\\", ".");
			if(currentFileFullPackage.endsWith(".")){
				currentFileFullPackage = currentFileFullPackage.substring(0,currentFileFullPackage.length()-1);
			}
			if(currentFileFullPackage.contains(".")){
				currentFileFullPackage = currentFileFullPackage.substring(currentFileFullPackage.indexOf(".")+1);
			}
			entity.setCurrentFileFullPackage(currentFileFullPackage);
			entity.setCurrentFileName(currentFileName);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		setAttribute("entity", entity);
		
		
		prepareEnvironmentVariables();
		op = rule.getTemplate().getId()+"";
		return "codeView";
	}
	
	//准备环境变量
	private void prepareEnvironmentVariables(){
		setAttribute("now", new Date());
		setAttribute("entityIteratorIndex", Integer.parseInt((String) getParameter("entityIteratorIndex")));
		
		Object value = null;
		for(EnvironmentVariable var : entity.getPackagee().getProject().getVariables()){
			try {
				switch(var.getDataType()){
				case 1:
					value = var.getValue();
					break;
				case 2:
					value = Integer.parseInt(var.getValue());
					break;
				case 3:
					value = Float.parseFloat(var.getValue());
					break;
				case 4:
					value = DateUtil.tryStr2Date(var.getValue());
					break;
				}
				setAttribute(var.getVarName(), value);
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * 批量导入
	 * @param file
	 * @param questnaireDef
	 * @throws Exception
	 */
	public int importEntityExcel(File file) throws Exception {
		Entity entity = null;
		Workbook book = Workbook.getWorkbook(file);
		//获得第一个工作表对象
		Sheet sheet = book.getSheet(0);
		//遍历记录
		int i = 1;//从第二行开始
		int success  = 0;
		resultInfo=new StringBuffer();
		ServletActionContext.getRequest().getSession().setAttribute("total", sheet.getRows()-1);
		ServletActionContext.getRequest().getSession().setAttribute("opera", "正在分析Excel...");
		List list = new ArrayList<Entity>();
		ServletActionContext.getRequest().getSession().setAttribute("total", sheet.getRows()-1);
		String packagename;
		for(;i < sheet.getRows();i++){
			try {
				ServletActionContext.getRequest().getSession().setAttribute("rowCount",i);
				appendMsg("<div class='Record'>");
				appendMsg("<span class='RowTitle'>第"+i+"行:</span>");
				entity = new Entity();
				//首先拿实体信息数据
				//赋值
				entity.setName((String)cellContentsToObject(sheet.getCell(0, i).getContents(),1,null,null));
				entity.setTableName((String)cellContentsToObject(sheet.getCell(1, i).getContents(),1,null,null));
				entity.setClassName((String)cellContentsToObject(sheet.getCell(2, i).getContents(),1,null,null));
				packagename = sheet.getCell(3, i).getContents();
				StringBuffer hql = new StringBuffer("FROM Packagee p where 1=1 ");
				List<Object> params = new ArrayList<Object>();
				int x = 0;
				for(String pName : packagename.split("\\.")){
					String temp = " and p";
					if(x!=0){
						for(int a=0;a<x; a++){
							temp+=".parent";
						}
					}
					temp+=".name=?";
					hql.append(temp);
					params.add(0,pName);
					x++;
				}
				List<Packagee> pList = packageService.findByHql(hql.toString(), params.toArray());
				if(pList.size()>0){
					entity.setPackagee(pList.get(0));
				}
				entity.setType((Integer)cellContentsToObject(sheet.getCell(4, i).getContents(),2,null,null));
				entity.setEnumValue((String)cellContentsToObject(sheet.getCell(5, i).getContents(),1,null,null));
				entity.setIdGenerateType((Integer)cellContentsToObject(sheet.getCell(6, i).getContents(),2,null,null));
				entity.setQueryAble((Integer)cellContentsToObject(sheet.getCell(7, i).getContents(),2,null,null));
				entity.setExportable((Integer)cellContentsToObject(sheet.getCell(8, i).getContents(),2,null,null));
				entity.setImportable((Integer)cellContentsToObject(sheet.getCell(9, i).getContents(),2,null,null));
				entity.setVisiablity((Integer)cellContentsToObject(sheet.getCell(10, i).getContents(),2,null,null));
				if(sheet.getCell(10, i).getContents()==null || sheet.getCell(10, i).getContents().trim().equals("")){
					entity.setVisiablity(1);
				}
				if(checkRepeat!=null && checkRepeat!=0){
					entity = getExistEntityInfo(entity);
					if(!existedEntityMapKey.trim().equals("")){
						if(existedEntityMap.get(existedEntityMapKey)!=null){
							appendMsg("第"+(i+1)+"行记录与之前的记录重复，已忽略<br/>");
							appendMsg("</div>");
							logger.info("第"+(i+1)+"行记录与之前的记录重复，已忽略");
							continue;
						}else{
							existedEntityMap.put(existedEntityMapKey, entity);
						}
					}
				}
					
				if(entity.getId()!=null){
					appendMsg("<font color='red'>导入失败:发现重复的实体信息，忽略该条记录。</font>");
					appendMsg("</div>");
					continue;
				}else{
					
					//entity.setAddTime(new Date());
				}
				appendMsg("<font color='red'>导入成功</font>");
				appendMsg("</div>");
				
				list.add(entity);
				success++;
			} catch (Exception e) {
				e.printStackTrace();
				appendMsg("遇到异常："+e.getMessage());
				appendMsg("</div>");  
				appendMsg("</div>");  
			}
		}
		ServletActionContext.getRequest().getSession().setAttribute("rowCount",0);
		ServletActionContext.getRequest().getSession().setAttribute("total", success);
		ServletActionContext.getRequest().getSession().setAttribute("opera", "正在添加答卷...");		

		if(list.size()>0){ 
			List tmpList = new ArrayList<Entity>();
			int size = 100;
			int count = 0;
			//System.out.println("list.size()="+list.size());
			for(int j=0;j<list.size();j++){
				tmpList.add(list.get(j));
				if(tmpList.size()%size==0 || j==list.size()-1){
					ServletActionContext.getRequest().getSession().setAttribute("rowCount",count);
					entityService.batchAdd(tmpList);
					tmpList = new ArrayList<Entity>();
				}
			}
		}
		msg = resultInfo.toString();
		ServletActionContext.getRequest().getSession().setAttribute("total", sheet.getRows()-1);
		ServletActionContext.getRequest().getSession().setAttribute("opera","完成!");
		book.close();
		return success;
	}
	
	/**
	 * 根据excel中的客户信息查询现有的实体信息，如果存在相同的客户信息，使用现有的实体  
	 * @param qi
	 * @param entity
	 * @return
	 */
	private Entity getExistEntityInfo(Entity entity){
		//这里认为entity已经被初始化，并且已经对字段赋值
		StringBuffer hql = new StringBuffer("FROM Entity c WHERE 1=1 ");
		List<Object> paramValues = new ArrayList<Object>();
		Object propValue;
		existedEntityMapKey = "";
		for(String  propName : validatePropNames){
			propValue = PropertityUtil.getProp(entity, propName);
			if(propValue!=null && !"".equals(propValue.toString().trim())){
				hql.append(" AND c.").append(propName).append("=? ");
				paramValues.add(propValue);
			}
			//整理非重复验证的键
			existedEntityMapKey += propValue==null?"":propValue.toString();
		}
		List<Entity> tmpList = entityService.findByHql(hql.toString(), paramValues.toArray());
		if(tmpList!=null && tmpList.size()>0){
			appendMsg("<font color='red'>使用已存在的实体信息。</font>"); 
			return tmpList.get(0);
		}
		return entity;
	}
	
	
	/**
	 * 初始化重复验证字段List
	 */
	private void initValidateProps(){
		if(optionalIds!=null){
			validatePropNames = new ArrayList<String>();
			for(Integer id : optionalIds){
				validatePropNames.add(getPropName(id));
			}
		}
	}
	private String getPropName(int optionalId){
		switch(optionalId){
			case 1 : return "name";
			case 2 : return "tableName";
			case 3 : return "className";
			case 4 : return "packagee";
			case 5 : return "queryAble";
			case 6 : return "exportable";
			case 7 : return "importable";
			case 8 : return "visiablity";
		}
		return null;
	}
	/**
	 * 从excel的字符串值转化成实体对象的属性值,不支持复杂类型
	 * @param strValue
	 * @param dataType 1 for String , 2 for Integer , 3 for Float,4 for Data, 5 for Dictionary
	 * @return
	 */
	private Object cellContentsToObject(String strValue,int dataType,String timeFormat,String dicFix){
		if(strValue == null || strValue.trim().equals("")){
			switch(dataType){
			case 1:
				return strValue;
			case 2:
				return new Integer(0);
			case 3:
				return new Float(0);
			case 4:
			case 5:
			default:
				return null;
			}
		}
		try{
			switch(dataType){
			case 1:
				return strValue;
			case 2:
				return Integer.parseInt(strValue);
			case 3:
				return Float.parseFloat(strValue);
			case 4:
				return new SimpleDateFormat(timeFormat).parse(strValue);
			case 5:
				return dictionaryDetailService.getDetailByDictionaryNumberAndName(dicFix, strValue);
			default:
					break;
			}
		}catch(Exception e){
			return null;
		}
		return null;
	}
	
	/**
	 * 从excel的字符串值转化成实体对象的复杂类型属性值
	 * @param strValue 从excel中读取的字符串值
	 * @param service 操作数据库的service
	 * @param propName 对应复杂类型的字段
	 * @param className 对应复杂类型的类
	 * @param valuePath 对应复杂类型的valuePath
	 * @return
	 */
	private Object cellContentsToComplexObject(String strValue,IBaseService service,String className,String valuePath){
		if(strValue==null){
			return null;
		}
		strValue = strValue.trim();
		String propValue = strValue.replaceAll("\\[id=\\d{0,}\\]", "");
		String idValue = strValue.replaceAll(propValue, "");
		idValue = idValue.replaceAll("[^\\d]{0,}", "");
		
		try{
			if(idValue!=null && !idValue.trim().equals("")){//按id查询
				return service.findById(Integer.parseInt(idValue));
			}else{//按名称查询
				StringBuffer hql = new StringBuffer();
				hql.append("FROM ").append(className).append(" alias WHERE alias.").append(valuePath);
				hql.append("=? ");
				List list = service.findByHql(hql.toString(),new Object[] { propValue });
				if (list != null && list.size() > 0) {
					return list.get(0);
				}
			}
		}catch(Exception e){
			return null;
		}
		return null;
	}
	private EntityAction appendMsg(Object obj){
		resultInfo.append(obj);
		return EntityAction.this;
	}
	/**
	 * 导入进度数据
	 * @param content
	 */
	public String importProgress(){
		Integer total =(Integer) (ServletActionContext.getRequest().getSession().getAttribute("total")==null?0:ServletActionContext.getRequest().getSession().getAttribute("total"));
		Integer rowCount = (Integer) (ServletActionContext.getRequest().getSession().getAttribute("rowCount")==null? 0 : ServletActionContext.getRequest().getSession().getAttribute("rowCount"));
		String msg = (String) ServletActionContext.getRequest().getSession().getAttribute("resultInfo");
		String opera = (String) ServletActionContext.getRequest().getSession().getAttribute("opera");
		msg = msg ==null? "" : msg;
		StringBuffer res = new StringBuffer();
		if(ServletActionContext.getRequest().getParameter("first")!=null){
			res.append("[{\"total\":\"").append(total).append("\",\"rowCount\":\"").append(rowCount).append("\",");
			res.append("\"complate\":\"").append(total.equals(rowCount)).append("\",");
			res.append("\"opera\":\"").append(opera==null?"":opera).append("\"}]");
			write(res.toString());
			return null;
		}else{
			return SUCCESS;
		}
	}
	/**
	 * 向浏览器写数据
	 * @param content
	 */
	private void write(String content) {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.write(content);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 导出Excel模板
	 * @return
	 * @throws Exception
	 */
	public String exportEmptyExcel() throws Exception{
		String cols= "名称;表名称;类名称;所属包;类型(0:普通类,1:枚举);枚举值(示例:Male=男；Female=女);主键生成方式(0:自增长主键,1:指定型主键);是否可查询;是否可导出;是否可导入;对生成器可见";
		List<String> columnNames = new ArrayList<String>();
		for(String col:cols.split(";")){
			columnNames.add(col);
		}
		createEmptyExcel(columnNames,"实体导入模板");
		return null;
	}
	
	public void createEmptyExcel(List<String> columnNames,String fileName) throws Exception {
		//生成临时文件
		File fdir = new File("fileUpload");
		if (!fdir.exists())
			fdir.mkdir();
		File result = null;
		result = new File(fdir.getAbsoluteFile() + "/" + fileName + ".xls");
		if (!result.exists()) {
			result.createNewFile();
		}
		//生成excel内容
		WritableWorkbook book = Workbook.createWorkbook(result);
		WritableSheet sheet = book.createSheet(fileName, 1);
		
		WritableFont wf = new WritableFont(WritableFont.ARIAL,11,WritableFont.BOLD,false);
		wf.setColour(Colour.WHITE);
		WritableCellFormat wcf = new WritableCellFormat(wf);
		wcf.setAlignment(Alignment.CENTRE);
		wcf.setBackground(Colour.GREEN);
		wcf.setBorder(Border.ALL, BorderLineStyle.THIN);
		
		for(int i=0;i<columnNames.size();i++){
			sheet.setColumnView(i, 20);
			sheet.addCell(new Label(i,0,columnNames.get(i),wcf));
		}
		//写入数据并关闭文件
		book.write();
		book.close();
		entityService.downLoad(result.getAbsolutePath(), ServletActionContext.getResponse(), false);
	}
	//与导入相关的代码结束=============================================================================================
	
	
	public String addPageCode(){
		
		return SUCCESS;
	}	
	public String updatePageCode(){
		
		return SUCCESS;
	}	
	public String listPageCode(){
		
		return SUCCESS;
	}	
	public String controllerCode(){
		
		return SUCCESS;
	}	
	public String serviceCode(){
		
		return SUCCESS;
	}	
	public String serviceImplCode(){
		
		return SUCCESS;
	}	
	public String daoCode(){
		
		return SUCCESS;
	}	
	public String entity_daoImplCode(){
		
		return SUCCESS;
	}	
	
	
	public void prepareModel(){
		if(id!=null){
			entity = entityService.findById(id);
		}else{
			entity = new Entity();
		}
	}
	
	public String list(){
		initPage();
		Project project = (Project) ServletActionContext.getRequest().getSession().getAttribute("PROJECT");
		if(project!=null && projectId==null){
			projectId = project.getId();
		}
		projectList = projectService.findAll();
		if(projectId!=null){
			parentPacks = new ArrayList<Packagee>();
			CommonUtil.tree(packageService.findByHql("FROM Packagee p WHERE p.parent is NULL AND p.project.id=?", new Object[]{projectId}), parentPacks, "", null);
		}
		StringBuffer hql = new StringBuffer("FROM Entity e WHERE 1=1");
		List<Object> params = new ArrayList<Object>();
		if(packageId!=null){
			hql.append(" AND e.packagee.id=? ");
			params.add(packageId);
		}else if(projectId!=null){
			hql.append(" AND e.packagee.project.id=? ");
			params.add(projectId);
		}
		pageBean = entityService.findPageBeanOfHql(hql.toString(), pageNum, pageSize, params.toArray());
		return SUCCESS;
	}
	
	
	public String addUI(){
		parentPacks = new ArrayList<Packagee>();
		Project project = (Project) ServletActionContext.getRequest().getSession().getAttribute("PROJECT");
		if(project!=null){
			CommonUtil.tree(packageService.findByHql("FROM Packagee p WHERE p.parent is NULL AND p.project.id=?", new Object[]{project.getId()}), parentPacks, "", null);
		}else{
			CommonUtil.tree(packageService.findByHql("FROM Packagee p WHERE p.parent is NULL", null), parentPacks, "", null);
		}
		return SUCCESS;
	}
	
	public String add(){
		if(packageId!=null){
			entity.setPackagee(packageService.findById(packageId));
		}else{
			entity.setPackagee(null);
		}http://www.baidu.com/link?url=dGUnzB5M3gu2yTlvDyo4wLJZsj5dt8GMOWdXSkWR9jtTGr5jsHu6CSRmm268Bm57-Uow2-l_S-jASjWbM5Gxya
		entityService.add(entity);
		return RELOAD;
	}
	
	public String updateUI(){
		parentPacks = new ArrayList<Packagee>();
		Project project = (Project) ServletActionContext.getRequest().getSession().getAttribute("PROJECT");
		if(project!=null){
			CommonUtil.tree(packageService.findByHql("FROM Packagee p WHERE p.parent is NULL AND p.project.id=?", new Object[]{project.getId()}), parentPacks, "", null);
		}else{
			CommonUtil.tree(packageService.findByHql("FROM Packagee p WHERE p.parent is NULL", null), parentPacks, "", null);
		}
		return SUCCESS;
	}
	
	public String update(){
		if(packageId!=null){
			entity.setPackagee(packageService.findById(packageId));
		}else{
			entity.setPackagee(null);
		}
		entityService.update(entity);
		return RELOAD;
	}
	
	public String delete(){
		if(ids!=null){
			entityService.batchDelete(ids);
		}
		return RELOAD;
	}

	public Integer getPackageId() {
		return packageId;
	}

	public void setPackageId(Integer packageId) {
		this.packageId = packageId;
	}

	public Entity getEntity() {
		return entity;
	}

	public void setEntity(Entity entity) {
		this.entity = entity;
	}

	public List<Packagee> getParentPacks() {
		return parentPacks;
	}

	public void setParentPacks(List<Packagee> parentPacks) {
		this.parentPacks = parentPacks;
	}
	public List<Project> getProjectList() {
		return projectList;
	}
	public void setProjectList(List<Project> projectList) {
		this.projectList = projectList;
	}
	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public String getFormTimeId() {
		return formTimeId;
	}

	public void setFormTimeId(String formTimeId) {
		this.formTimeId = formTimeId;
	}

	public Integer getCheckRepeat() {
		return checkRepeat;
	}

	public void setCheckRepeat(Integer checkRepeat) {
		this.checkRepeat = checkRepeat;
	}

	public StringBuffer getResultInfo() {
		return resultInfo;
	}

	public void setResultInfo(StringBuffer resultInfo) {
		this.resultInfo = resultInfo;
	}

	public Integer[] getOptionalIds() {
		return optionalIds;
	}

	public void setOptionalIds(Integer[] optionalIds) {
		this.optionalIds = optionalIds;
	}

	public File getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(File excelFile) {
		this.excelFile = excelFile;
	}

	public Integer getRuleId() {
		return ruleId;
	}

	public void setRuleId(Integer ruleId) {
		this.ruleId = ruleId;
	}
	
	
}
