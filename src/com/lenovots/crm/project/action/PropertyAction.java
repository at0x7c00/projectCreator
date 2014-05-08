package com.lenovots.crm.project.action;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
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
import com.lenovots.crm.project.entity.Packagee;
import com.lenovots.crm.project.entity.Project;
import com.lenovots.crm.project.entity.Property;
import com.lenovots.crm.project.service.IEntityService;
import com.lenovots.crm.project.service.IPackageService;
import com.lenovots.crm.project.service.IProjectService;
import com.lenovots.crm.project.service.IPropertyService;
import com.lenovots.crm.util.CommonUtil;
import com.lenovots.crm.util.PropertityUtil;



@Controller("propertyAction")
@Scope(value="prototype")
public class PropertyAction extends BaseAction<Property> {
	
	private static Logger logger = Logger.getLogger(PropertyAction.class);
	
	@Resource
	private IPropertyService propertyService;
	@Resource
	private IEntityService entityService;
	@Resource
	private IProjectService projectService;
	@Resource
	private IPackageService	packageService;
	
	private Property property;
	private List<Entity> entityList;
	private List<Packagee> parentPacks;
	private List<Project> projectList;
	
	private Integer entityId;
	private Integer packageId;
	private Integer projectId;
	
	private Integer complexId;
	private Entity entityy;
	
	private static final long serialVersionUID = 8856961694147206209L;
	
	
	//与导入相关的字段开始================================================================
	private Integer checkRepeat=0;
	private String formTimeId;//防止重复提交
	private StringBuffer resultInfo;
	private List<String> validatePropNames;
	private Integer[] optionalIds;
	private Map<String,Property> existedPropertyMap = new HashMap<String, Property>();
	private String  existedPropertyMapKey;
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
				int success = importPropertyExcel(excelFile);
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
		anyAction="property";
		op="importReport";    
		return ANYFORWARD;
	}
	/**
	 * 批量导入
	 * @param file
	 * @param questnaireDef
	 * @throws Exception
	 */
	public int importPropertyExcel(File file) throws Exception {
		Property property = null;
		Workbook book = Workbook.getWorkbook(file);
		//获得第一个工作表对象
		Sheet sheet = book.getSheet(0);
		//遍历记录
		int i = 1;//从第二行开始
		int success  = 0;
		resultInfo=new StringBuffer();
		ServletActionContext.getRequest().getSession().setAttribute("total", sheet.getRows()-1);
		ServletActionContext.getRequest().getSession().setAttribute("opera", "正在分析Excel...");
		List list = new ArrayList<Property>();
		ServletActionContext.getRequest().getSession().setAttribute("total", sheet.getRows()-1);
		for(;i < sheet.getRows();i++){
			try {
				ServletActionContext.getRequest().getSession().setAttribute("rowCount",i);
				appendMsg("<div class='Record'>");
				appendMsg("<span class='RowTitle'>第"+i+"行:</span>");
				property = new Property();
				//首先拿字段信息数据
				//赋值
				property.setEntity((Entity)cellContentsToComplexObject(sheet.getCell(0, i).getContents(),entityService,"Entity","name"));
				property.setName((String)cellContentsToObject(sheet.getCell(1, i).getContents(),1,null,null));
				property.setPropName((String)cellContentsToObject(sheet.getCell(2, i).getContents(),1,null,null));
				property.setColumnName((String)cellContentsToObject(sheet.getCell(3, i).getContents(),1,null,null));
				property.setDataType((Integer)cellContentsToObject(sheet.getCell(4, i).getContents(),2,null,null));
				property.setIsTextArea((Integer)cellContentsToObject(sheet.getCell(5, i).getContents(),2,null,null));
				property.setLength((Integer)cellContentsToObject(sheet.getCell(6, i).getContents(),2,null,null));
				property.setCanNull((Integer)cellContentsToObject(sheet.getCell(7, i).getContents(),2,null,null));
				property.setRelationType((Integer)cellContentsToObject(sheet.getCell(8, i).getContents(),2,null,null));
				
				property.setComplexEntity((Entity)cellContentsToComplexObject(sheet.getCell(9, i).getContents(),entityService,"Entity","className"));
				if(property.getComplexEntity()==null && 6==property.getDataType()){
					logger.error("complex data type property:"+property.getName()+" does not find a complex entity use entity name : "+sheet.getCell(9, i).getContents());
				}
				
				property.setValuePath((String)cellContentsToObject(sheet.getCell(10, i).getContents(),1,null,null));
				property.setSetKeyCoumn((String)cellContentsToObject(sheet.getCell(11, i).getContents(),1,null,null));
				property.setForQuery((Integer)cellContentsToObject(sheet.getCell(12, i).getContents(),2,null,null));
				property.setDisplay((Integer)cellContentsToObject(sheet.getCell(13, i).getContents(),2,null,null));
				
				property.setBriefLength((Integer)cellContentsToObject(sheet.getCell(14, i).getContents(),2,null,null));
				property.setTimeFormat((String)cellContentsToObject(sheet.getCell(15, i).getContents(),1,null,null));
				property.setIsTotalRow((Integer)cellContentsToObject(sheet.getCell(16, i).getContents(),2,null,null));
				property.setRow((String)cellContentsToObject(sheet.getCell(17, i).getContents(),1,null,null));
				property.setCol((String)cellContentsToObject(sheet.getCell(18, i).getContents(),1,null,null));
				property.setSortValue((Integer)cellContentsToObject(sheet.getCell(19, i).getContents(),2,null,null));
				property.setOnlyRelationship((Integer)cellContentsToObject(sheet.getCell(20, i).getContents(),2,null,null));
				property.setIsId((Integer)cellContentsToObject(sheet.getCell(21, i).getContents(),2,null,null));
				property.setMiddletable((String)cellContentsToObject(sheet.getCell(22, i).getContents(),1,null,null));
				property.setIsTextStringType((Integer)cellContentsToObject(sheet.getCell(23, i).getContents(),2,null,null));
				
				
//				property.setDictFix((String)cellContentsToObject(sheet.getCell(8, i).getContents(),1,null,null));
//				property.setOnlyRelationship((Integer)cellContentsToObject(sheet.getCell(21, i).getContents(),2,null,null));

				if(checkRepeat!=null && checkRepeat!=0){
					property = getExistPropertyInfo(property);
					if(!existedPropertyMapKey.trim().equals("")){
						if(existedPropertyMap.get(existedPropertyMapKey)!=null){
							appendMsg("第"+(i+1)+"行记录与之前的记录重复，已忽略<br/>");
							appendMsg("</div>");
							logger.info("第"+(i+1)+"行记录与之前的记录重复，已忽略");
							continue;
						}else{
							existedPropertyMap.put(existedPropertyMapKey, property);
						}
					}
				}
					
				if(property.getId()!=null){
					appendMsg("<font color='red'>导入失败:发现重复的字段信息，忽略该条记录。</font>");
					appendMsg("</div>");
					continue;
				}else{
					
					//property.setAddTime(new Date());
				}
				appendMsg("<font color='red'>导入成功</font>");
				appendMsg("</div>");
				
				list.add(property);
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
		ServletActionContext.getRequest().getSession().setAttribute("opera", "正在添加数据...");		

		if(list.size()>0){ 
			List tmpList = new ArrayList<Property>();
			int size = 100;
			int count = 0;
			//System.out.println("list.size()="+list.size());
			for(int j=0;j<list.size();j++){
				tmpList.add(list.get(j));
				if(tmpList.size()%size==0 || j==list.size()-1){
					ServletActionContext.getRequest().getSession().setAttribute("rowCount",count);
					propertyService.batchAdd(tmpList);
					tmpList = new ArrayList<Property>();
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
	 * 根据excel中的客户信息查询现有的字段信息，如果存在相同的客户信息，使用现有的字段  
	 * @param qi
	 * @param property
	 * @return
	 */
	private Property getExistPropertyInfo(Property property){
		//这里认为property已经被初始化，并且已经对字段赋值
		StringBuffer hql = new StringBuffer("FROM Property c WHERE 1=1 ");
		List<Object> paramValues = new ArrayList<Object>();
		Object propValue;
		existedPropertyMapKey = "";
		for(String  propName : validatePropNames){
			propValue = PropertityUtil.getProp(property, propName);
			if(propValue!=null && !"".equals(propValue.toString().trim())){
				hql.append(" AND c.").append(propName).append("=? ");
				paramValues.add(propValue);
			}
			//整理非重复验证的键
			existedPropertyMapKey += propValue==null?"":propValue.toString();
		}
		List<Property> tmpList = propertyService.findByHql(hql.toString(), paramValues.toArray());
		if(tmpList!=null && tmpList.size()>0){
			appendMsg("<font color='red'>使用已存在的字段信息。</font>"); 
			return tmpList.get(0);
		}
		return property;
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
			case 1 : return "entity";
			case 2 : return "isTextArea";
			case 3 : return "name";
			case 4 : return "propName";
			case 5 : return "length";
			case 6 : return "canNull";
			case 7 : return "dataType";
			case 8 : return "dictFix";
			case 9 : return "valuePath";
			case 10 : return "timeFormat";
			case 11 : return "sortValue";
			case 12 : return "display";
			case 13 : return "forQuery";
			case 14 : return "relationType";
			case 15 : return "complexEntity";
			case 16 : return "isTotalRow";
			case 17 : return "setKeyCoumn";
			case 18 : return "briefLength";
			case 19 : return "row";
			case 20 : return "col";
			case 21 : return "onlyRelationship";

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
	private PropertyAction appendMsg(Object obj){
		resultInfo.append(obj);
		return PropertyAction.this;
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
		String cols= "所属实体;显示名称;字段名称;列名称;数据类型;文本域显示;字段长度;允许为空;复杂类型关联关系;复杂类型关联实体;valuePath;mappedby;可查询;列表显示;简略显示长度;日期格式;整行显示;row;col;排序值;关系字段;主键;text";
		List<String> columnNames = new ArrayList<String>();
		for(String col:cols.split(";")){
			columnNames.add(col);
		}
		createEmptyExcel(columnNames,"字段导入模板");
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
		propertyService.downLoad(result.getAbsolutePath(), ServletActionContext.getResponse(), false);
	}
	//与导入相关的代码结束=============================================================================================
	
	public void prepareModel(){
		if(id!=null){
			property = propertyService.findById(id);
		}else{
			property = new Property();
		}
	}
	
	public String addUI(){
		Project project = (Project) ServletActionContext.getRequest().getSession().getAttribute("PROJECT");
		if(project!=null){
			entityList = entityService.findByHql("FROM Entity e WHERE e.packagee.project.id=? ", new Object[]{project.getId()});
		}else{
			entityList = entityService.findByHql("FROM Entity", null);
		}
		entityy = entityService.findById(entityId);
		return SUCCESS;
	}
	
	public String add(){
		entityy = entityService.findById(entityId);
		if(entityy==null){
			return RELOAD;
		}
		if(property.getDataType().equals(Property.DATATYPE_COMPLEX) || property.getDataType().equals(Property.DATATYPE_ENUM)){
			property.setComplexEntity(entityService.findById(complexId));
		}
		//数据字典的关联关系是多对一
		if(property.getDataType().equals(Property.DATATYPE_DICTIONARY)){
			property.setRelationType(Property.RELATIONTYPE_MANY_TO_ONE);
		}
		if(property.getRelationType()==null){
			property.setRelationType(0);
		}
		property.setEntity(entityy);
		propertyService.add(property);
		entityy.getProperties().add(property);
		entityService.update(entityy);
		setAttribute("entityId", entityId);
		return RELOAD;
	}
	
	/**
	 * 显示列表
	 */
	public String list() throws Exception{
		initPage();
		Project project = (Project) ServletActionContext.getRequest().getSession().getAttribute("PROJECT");
		if(project!=null && projectId==null){
			projectId = project.getId();
		}
		projectList = projectService.findAll();
		entityList = entityService.findAll();
		if(projectId!=null){
			parentPacks = new ArrayList<Packagee>();
			CommonUtil.tree(packageService.findByHql("FROM Packagee p WHERE p.project.id=? AND p.parent is null", new Object[]{projectId}), parentPacks, "", null);
		}
		
		String tmpStr = (String)getParameter("entityId");
		if(tmpStr!=null && !tmpStr.trim().equals("")){
			entityId = Integer.parseInt(tmpStr);
		}
		StringBuffer hql = new StringBuffer("FROM Property p WHERE 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(entityId!=null){
			hql.append(" AND p.entity.id=?");
			params.add(entityId);
		}else if(packageId!=null){
			entityList = entityService.findByHql("FROM Entity e WHERE e.packagee.id=?", new Object[]{packageId});
			hql.append(" AND p.entity.packagee.id=?");
			params.add(packageId);
		}else if(projectId!=null){
			hql.append(" AND p.entity.packagee.project.id=?");
			params.add(projectId);
		}
		pageBean = propertyService.findPageBeanOfHql(hql.toString(), pageNum, pageSize,params.toArray());
		return SUCCESS;
	}
	
	public String updateUI(){
		Project project = (Project) ServletActionContext.getRequest().getSession().getAttribute("PROJECT");
		if(project!=null){
			entityList = entityService.findByHql("FROM Entity e WHERE e.packagee.project.id=? ", new Object[]{project.getId()});
		}else{
			entityList = entityService.findByHql("FROM Entity", null);
		}
		return SUCCESS;
	}
	
	public String update(){
		entityy = entityService.findById(entityId);
		if(entityy==null){
			return RELOAD;
		}
		if(property.getDataType().equals(Property.DATATYPE_COMPLEX) || property.getDataType().equals(Property.DATATYPE_ENUM)){
			property.setComplexEntity(entityService.findById(complexId));
		}
		//数据字典的关联关系是多对一
		if(property.getDataType().equals(Property.DATATYPE_DICTIONARY)){
			property.setRelationType(Property.RELATIONTYPE_MANY_TO_ONE);
		}
		if(property.getRelationType()==null){
			property.setRelationType(0);
		}
		property.setEntity(entityy);
		if(property.getRelationType()==null){
			property.setRelationType(0);
		}
		entityy.getProperties().add(property);
		entityService.update(entityy);
		
		return RELOAD;
	}
	
	public String delete(){
		if(ids!=null){
			propertyService.batchDelete(ids);
		}
		return RELOAD;
	}

	public List<Entity> getEntityList() {
		return entityList;
	}

	public void setEntityList(List<Entity> entityList) {
		this.entityList = entityList;
	}

	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public Entity getEntityy() {
		return entityy;
	}

	public void setEntityy(Entity entityy) {
		this.entityy = entityy;
	}

	public Integer getEntityId() {
		return entityId;
	}

	public void setEntityId(Integer entityId) {
		this.entityId = entityId;
	}

	public Integer getComplexId() {
		return complexId;
	}

	public void setComplexId(Integer complexId) {
		this.complexId = complexId;
	}

	public List<Project> getProjectList() {
		return projectList;
	}

	public void setProjectList(List<Project> projectList) {
		this.projectList = projectList;
	}

	public Integer getPackageId() {
		return packageId;
	}

	public void setPackageId(Integer packageId) {
		this.packageId = packageId;
	}

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public List<Packagee> getParentPacks() {
		return parentPacks;
	}

	public void setParentPacks(List<Packagee> parentPacks) {
		this.parentPacks = parentPacks;
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

	public void setOptionalIds(Integer[] optionalIds) {
		this.optionalIds = optionalIds;
	}

	public void setExcelFile(File excelFile) {
		this.excelFile = excelFile;
	}
}
