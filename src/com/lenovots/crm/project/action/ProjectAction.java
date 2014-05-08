package com.lenovots.crm.project.action;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lenovots.crm.common.action.BaseAction;
import com.lenovots.crm.project.entity.Entity;
import com.lenovots.crm.project.entity.EnvironmentVariable;
import com.lenovots.crm.project.entity.MyFile;
import com.lenovots.crm.project.entity.Project;
import com.lenovots.crm.project.entity.Rule;
import com.lenovots.crm.project.entity.Template;
import com.lenovots.crm.project.service.IEntityService;
import com.lenovots.crm.project.service.IEnvironmentVariableService;
import com.lenovots.crm.project.service.IProjectService;
import com.lenovots.crm.project.service.IRuleService;
import com.lenovots.crm.util.Constants;
import com.lenovots.crm.util.ELUtil;
import com.lenovots.crm.util.URLUtil;
import com.lenovots.crm.util.ZipCompressor;



@Controller("projectAction")
@Scope(value="prototype")
public class ProjectAction extends BaseAction<Project> {
	
	static Logger log = Logger.getLogger(ProjectAction.class);
	@Resource
	private IProjectService projectService;
	@Resource
	private IEntityService entityService;
	@Resource
	private IRuleService ruleService;
	@Resource
	private IEnvironmentVariableService environmentVariableService;
	
	private Project project;
	private List<Entity> entityList;
	private Integer entityId;
	private Integer complexId;
	private Entity entityy;
	private Integer[] ruleIds;
	private Integer[] envirVarIds;
	private List<Rule> ruleList;
	private List<EnvironmentVariable> envirVars;
	private String dir;
	private Integer ruleId;
	
	private static final long serialVersionUID = 8856961694147206209L;
	
	public void prepareModel(){
		if(id!=null){
			project = projectService.findById(id);
		}else{
			project = new Project();
		}
	}
	
	
	public String list(){
		initPage();
		pageBean = projectService.findPageBeanOfHql("FROM Project", pageNum, pageSize, null);
		return SUCCESS;
	}
	
	public String addUI(){
		ruleList = ruleService.findAll();
		envirVars = environmentVariableService.findAll();
		return SUCCESS;
	}
	
	public String add(){
		projectService.add(project);
		if (ruleIds != null) {
			for (int i = 0; i < ruleIds.length; i++) {
				project.getRules().add(ruleService.findById(ruleIds[i]));
			}
		}
		if (envirVarIds != null) {
			for (int i = 0; i < envirVarIds.length; i++) {
				project.getVariables().add(environmentVariableService.findById(envirVarIds[i]));
			}
		}
		projectService.update(project);
		return RELOAD;
	}
	
	public void prepareBuild(){
		prepareModel();
	}
	
	/**
	 * 构建代码
	 * @return
	 */
	public String build(){
		project = projectService.findById(id);
		List<Entity> entities = entityService.findByHql("FROM Entity e WHERE e.packagee.project.id=? ", new Object[]{project.getId()});
		String codeSaveRoot = ServletActionContext.getServletContext().getRealPath(Constants.CODE_SAVE_ROOT)+File.separator+project.getName()+File.separator;
		Rule rule = null;
		ELUtil elUtil = ELUtil.getInstance();
		String outputDir = null;
		String outputFileName = null;
		File outputFile = null;
		int i = 0;
		for(Entity entity : entities){
			if(entity.getVisiablity()==0){
				continue;
			}
			i++;
			elUtil.setAttribute("entity", entity);
			rule = ruleService.findById(ruleId);
			try {
				if(!elUtil.causeValidate(entity, rule.getCause())){
					continue;
				}
			} catch (Exception e1) {
				e1.printStackTrace();
				log.info("查询条件错误:"+rule.getTemplate().getName()+","+rule.getCause());
				continue;
			}
			try {
				outputDir = elUtil.parse(rule.getOutputDir());
				outputDir = elUtil.calcuteRelativePath(outputDir);
				outputDir = outputDir.replaceAll("\\.", "\\"+File.separator);
				
				outputFileName = elUtil.parse(rule.getOutputFileName());
				if(outputDir.startsWith(File.separator)){
					outputDir = outputDir.substring(1);
				}
				if(!outputDir.endsWith(File.separator)){
					outputDir+=File.separator;
				} 
				outputFile = new File(codeSaveRoot+outputDir+outputFileName);
			} catch (Exception e) {
				log.error("映射规则输出位置配置错误:"+e.getMessage());
				e.printStackTrace();
			}
			if(outputFile!=null){
				String url = "http://localhost:8080/projectCreator-bpm/entity_codeView.action?id="+entity.getId()+"&ruleId="+ruleId+"&entityIteratorIndex="+i;
				String content = URLUtil.getURLContent(url);
				
				if(rule.getTemplate().getType()==Template.TEMPLATE_TYPE_JSP){
					content = content.replaceAll(Constants.LT_R,"<");
					content = content.replaceAll(Constants.GT_R,">");
					content = content.replaceAll(Constants.DOLLAR_R,"\\$");
				}
				StringBuffer temp = new StringBuffer();
				for(String str : content.split("\r")){
					if(!str.trim().equals("")){
						temp.append(str);
					}
				}
				content = temp.toString();
				URLUtil.saveContentToFile(content, outputFile,rule.isAppend());
				log.info("生成文件:"+outputFile.getAbsolutePath());
			}
		}
		return RELOAD;
	}

	
	public String detail(){
		ruleList = ruleService.findAll();
		project  = projectService.findById(id);
		return SUCCESS;
	}
	
	public String updateUI(){
		ruleList = ruleService.findAll();
		envirVars = environmentVariableService.findAll();
		return SUCCESS;
	}
	
	public String update(){
		Set<Rule> temp = new HashSet<Rule>();
		Iterator<Rule> iter = project.getRules().iterator();
		while (iter.hasNext()) {
			temp.add(iter.next());
		}
		project.getRules().removeAll(temp);
		if (ruleIds != null) {
			for (int i = 0; i < ruleIds.length; i++) {
				project.getRules().add(ruleService.findById(ruleIds[i]));
			}
		}
		project.getVariables().clear();
		if (envirVarIds != null) {
			for (int i = 0; i < envirVarIds.length; i++) {
				project.getVariables().add(environmentVariableService.findById(envirVarIds[i]));
			}
		}
		projectService.update(project);
		return RELOAD;
	}
	
	public String delete(){
		if(ids!=null){
			for(Integer id : ids){
				project = projectService.findById(id);
				project.getRules().clear();
			}
			projectService.batchDelete(ids);
		}
		return RELOAD;
	}
	
	public String select(){
		project = projectService.findById(id);
		ServletActionContext.getRequest().getSession().setAttribute("PROJECT", project);
		return RELOAD;
	}
	
	/**
	 * 查看项目生成结果
	 * @return
	 */
	public String viewFile(){
		project = projectService.findById(id);
		String projectRootDir = ServletActionContext.getServletContext().getRealPath(Constants.CODE_SAVE_ROOT+project.getName());
		File file = new File(projectRootDir);
		if(!file.exists()){
			file.mkdirs();
		}
		if(dir!=null){
			projectRootDir+=File.separator+dir;
			file = new File(projectRootDir);
		}
		if(file.isFile()){
		}else{
			List<MyFile> parents = new ArrayList<MyFile>();
			File parent = new File(file.getAbsolutePath());
			String fileName;
			while(!parent.getName().equals(project.getName())){
				parents.add(0,new MyFile(parent,project.getName()));
				fileName = parent.getAbsolutePath();
				fileName = fileName.substring(0,fileName.lastIndexOf(File.separator));
				parent = new File(fileName);
			}
			setAttribute("parents", parents);
			List<MyFile> myfiles = new ArrayList<MyFile>();
			for(File f : file.listFiles()){
				myfiles.add(new MyFile(f,project.getName()));
			}
			setAttribute("files", myfiles);
		}
		return SUCCESS;
	}
	
	public String downloadFile()throws Exception{
		project = projectService.findById(id);
		
		String projectRootDir = ServletActionContext.getServletContext().getRealPath(Constants.CODE_SAVE_ROOT+project.getName());
		File zipFile = new File("..\\temp\\"+new Date().getTime()+".zip");
		ZipCompressor zc = new ZipCompressor();
		zc.compress(projectRootDir,zipFile);
		
		HttpServletResponse response = ServletActionContext.getResponse();
		ServletOutputStream out = response.getOutputStream();
		String strFileName = URLEncoder.encode(project.getName(),"UTF-8");
		response.setContentType("application/msexcel;charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=" + strFileName+".zip");
		
		FileInputStream fis = new FileInputStream(zipFile);
		int i = 0;
		byte[] buffer = new byte[1024];
		while((i=fis.read(buffer))!=-1){
			out.write(buffer,0,i);
		}
		fis.close();
		out.close();
		zipFile.delete();
		return null;
	}
	
	public String checkCode(){
		project = projectService.findById(id);
		String fileName = ServletActionContext.getRequest().getParameter("fileName");
		if(fileName!=null){
			String codeSaveRoot = ServletActionContext.getServletContext().getRealPath(Constants.CODE_SAVE_ROOT+project.getName());
			File fileToCheck = new File(codeSaveRoot+File.separator+fileName);
			String content = null;
			try {
				content = URLUtil.readFile(fileToCheck, "UTF8");
			} catch (Exception e) {
				content = "读取文件时出现异常："+e.getMessage();
				e.printStackTrace();
			}
			setAttribute("fileContent", content);
			setAttribute("fileName", fileName);
		}
		op = "viewFile";
		return SUCCESS;
	}
	
	public String deleteCode(){
		project = projectService.findById(id);
		String deleteDir = ServletActionContext.getRequest().getParameter("deleteDir");
		if(deleteDir!=null){
			String codeSaveRoot = ServletActionContext.getServletContext().getRealPath(Constants.CODE_SAVE_ROOT+project.getName());
			File fileToDelete = new File(codeSaveRoot+File.separator+deleteDir);
			cascadeFileDelete(fileToDelete);
		}
		op = "viewFile";
		return REDIRECT;
	}
	
	private void cascadeFileDelete(File file){
		if(!file.exists()){
			return;
		}
		if(file.isDirectory()){
			for(File f : file.listFiles()){
				cascadeFileDelete(f);
			}
		}
		file.delete();
	}

	public List<Entity> getEntityList() {
		return entityList;
	}

	public void setEntityList(List<Entity> entityList) {
		this.entityList = entityList;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
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


	public Integer[] getRuleIds() {
		return ruleIds;
	}


	public void setRuleIds(Integer[] ruleIds) {
		this.ruleIds = ruleIds;
	}


	public List<Rule> getRuleList() {
		return ruleList;
	}


	public void setRuleList(List<Rule> ruleList) {
		this.ruleList = ruleList;
	}


	public String getDir() {
		return dir;
	}


	public void setDir(String dir) {
		this.dir = dir;
	}
	public Integer getRuleId() {
		return ruleId;
	}
	public void setRuleId(Integer ruleId) {
		this.ruleId = ruleId;
	}


	public Integer[] getEnvirVarIds() {
		return envirVarIds;
	}


	public void setEnvirVarIds(Integer[] envirVarIds) {
		this.envirVarIds = envirVarIds;
	}


	public List<EnvironmentVariable> getEnvirVars() {
		return envirVars;
	}
}
