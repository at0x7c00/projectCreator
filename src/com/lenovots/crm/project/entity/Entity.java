package com.lenovots.crm.project.entity;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;

import com.lenovots.crm.doc.annotation.InnerLabel;
import com.lenovots.crm.project.util.StrUtil;
import com.sun.star.uno.RuntimeException;

/**
 * 实体
 * @author 胡桥
 * Jul 9, 2012  1:31:18 PM
 */
@InnerLabel(name = "entity",desc = "实体、或者模型(Domain),又指模型驱动中的model,比如“学生”、“教师”等")
public class Entity {
	
	public static final int ID_GENERATE_TYPE_AUTO_INCREMENT = 0;
	public static final int ID_GENERATE_TYPE_ASSIGNED = 1;
	
	public static final int ENTITY_TYPE_CLASS = 0;
	public static final int ENTITY_TYPE_ENUM = 1;

	private Integer id;
	private String name;//意义名称
	private String tableName;//表名称
	private String className;//类名称
	private Packagee packagee;
	private Set<Property> properties;//字段属性
	
	private Set<TaskNode> taskNodes;//拥有的任务节点 
	
	private Integer queryAble=1;//是否可查询
	
	private Integer exportable = 0;//可导出
	
	private Integer importable = 0;//可导入
	
	private Integer visiablity=1;//可见 系统按照此标示判断是否导出
	
	private Integer idGenerateType = 0;//主键生成方式
	
	private Integer type = 0;
	
	private String enumValue;//枚举值
	
	private String currentFileFullPackage;
	private String currentFileName;
	
	@InnerLabel(name = "id",desc = "实体id号，自增长int类型")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@InnerLabel(name = "name",desc = "实体意义名称")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@InnerLabel(name  = "tableName",desc = "实体映射表名称")
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	@InnerLabel(name = "className",desc = "实体对应类名称")
	public String getClassName() {
		return className;
	}
	public String getEntityBeanName(){
		return getLowerClassName();
		//return this.className.toLowerCase();
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public Set<Property> getProperties() {
		if(properties == null){
			properties = new HashSet<Property>();
		}
		return properties;
	}
	public void setProperties(Set<Property> properties) {
		this.properties = properties;
	}
	public Packagee getPackagee() {
		return packagee;
	}
	public void setPackagee(Packagee packagee) {
		this.packagee = packagee;
	}
	
	public String getFullPackageName(){
		String fullClassName = getFullClassName();
		if(fullClassName.indexOf(".")<0){
			return null;
		}
		return fullClassName.substring(0, fullClassName.lastIndexOf("."));
	}
	
	public String getLowerClassName() {
		return getClassName().substring(0,1).toLowerCase()+getClassName().substring(1);
	}
	
	public String getFullClassName(){
		StringBuffer res = new StringBuffer();
		res.append(this.getClassName());
		Packagee parent = this.getPackagee();
		while(parent!=null){
			res.insert(0, parent.getName()+".");
			parent = parent.getParent();
		}
		return res.toString();
	}
	
	/**
	 * 获取主键列名称
	 * @return 例如 user_id、student_id
	 */
	public String getIdColumnNameForForeignUse(){
		Property idProp = getIdColumnProp();
		if(idProp==null){
			return this.className.toLowerCase()+"_id";
		}else{
			return idProp.getPropName();
		}
	}
	/**
	 * 获取主键列名称
	 * @return 例如 id、empNo
	 */
	public String getIdColumnName(){
		Property idProp = getIdColumnProp();
		if(idProp==null){
			return "id";
		}else{
			return idProp.getPropName();
		}
	}
	
	/**
	 * 获取主键列
	 * @return 自增长型主键返回null
	 */
	public Property getIdColumnProp(){
		if(this.idGenerateType==Entity.ID_GENERATE_TYPE_AUTO_INCREMENT){
			return null;
		}
		for(Property prop : this.getProperties()){
			if(1==prop.getIsId()){
				return prop;
			}
		}
		throw new RuntimeException("entity "+this.getClassName()+"'s id column is not exists!");
	}
	
	
	
	/**
	 * 获取主键get方法名称
	 * 例如employee的主键属性是empNo,则返回"getEmpNo"
	 * @return
	 */
	public String getIdCoumunGetterName(){
		Property idProp = getIdColumnProp();
		if(idProp==null){
			return "getId";
		}
		return "get"+StrUtil.upperCaseFirstChar(idProp.getPropName());
	}
	
	/**
	 * 获取属性getter方法名称
	 * @param prop
	 * @return 例如 getRole()
	 */
	public String getPropGetterName(Property prop){
		return "get"+StrUtil.upperCaseFirstChar(prop.getPropName());
	}
	
	/**
	 * 获取属性访问的getter方法名称
	 * @param prop
	 * @return 例如user.getRole
	 */
	public String getPropAccessGetterName(Property prop){
		return this.getLowerClassName()+".get"+StrUtil.upperCaseFirstChar(prop.getPropName());
	}
	
	/**
	 * 返回枚举类型SQL定义语句，用于类似@Column(columnDefinition="enum('Male','Female'))语句中
	 * @return 例如'Male','Female'
	 */
	public String getEnumDefinitionSQL(){
		StringBuffer res = new StringBuffer();
		if(this.getEnumValue()==null || this.getEnumValue().trim().equals("")){
			return res.toString();
		}
		for(String eqpart : this.getEnumValue().split(";")){
			res.append("'").append(eqpart.split("=")[0]).append("',");
		}
		if(res.length()>0){
			res.delete(res.length()-1, res.length());
		}
		return res.toString();
	}
	
	public Integer getQueryAble() {
		return queryAble;
	}
	public void setQueryAble(Integer queryAble) {
		this.queryAble = queryAble;
	}
	public Integer getExportable() {
		return exportable;
	}
	public void setExportable(Integer exportable) {
		this.exportable = exportable;
	}
	public Integer getImportable() {
		return importable;
	}
	public void setImportable(Integer importable) {
		this.importable = importable;
	}
	public Integer getVisiablity() {
		return visiablity;
	}
	public void setVisiablity(Integer visiablity) {
		this.visiablity = visiablity;
	}
	public Integer getIdGenerateType() {
		return idGenerateType;
	}
	public void setIdGenerateType(Integer idGenerateType) {
		this.idGenerateType = idGenerateType;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getEnumValue() {
		return enumValue;
	}
	public void setEnumValue(String enumValue) {
		this.enumValue = enumValue;
	}
	public  String getStr2Enum(){
		StringBuffer result = new StringBuffer();
		for(String eqpart : this.getEnumValue().split(";")){
			if(eqpart.trim().equals("")){
				continue;
			}
			String[] enumpart = eqpart.split("=");
			try{
				result.append(enumpart[0]).append("(\"").append(enumpart[1]).append("\")").append(",");
			}catch (Exception e) {
				System.out.println(eqpart);
			}
		}
		if(result.length()>0){
			result.delete(result.length()-1, result.length());
		}
		result.append(";");
		return result.toString();
	}
	
	public String getClassComment(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		StringBuffer res = new StringBuffer();
		res.append("/**\r\n");
		res.append(" * ").append(this.getName()).append("\r\n");
		res.append(" *").append(" @author pc").append("\r\n");
		res.append(" * ").append(sdf.format(new Date())).append("\r\n");
		res.append(" **/");
		return res.toString();
	}
	public Set<TaskNode> getTaskNodes() {
		return taskNodes;
	}
	public void setTaskNodes(Set<TaskNode> taskNodes) {
		this.taskNodes = taskNodes;
	}
	public String getCurrentFileFullPackage() {
		return currentFileFullPackage;
	}
	public void setCurrentFileFullPackage(String currentFileFullPackage) {
		this.currentFileFullPackage = currentFileFullPackage;
	}
	public String getCurrentFileName() {
		return currentFileName;
	}
	public void setCurrentFileName(String currentFileName) {
		this.currentFileName = currentFileName;
	}
}
