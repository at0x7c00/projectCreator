package com.lenovots.crm.project.entity;


/**
 * 字段属性
 * @author 胡桥
 * Jul 9, 2012  1:33:01 PM
 */
public class Property {
	
	public static final int DATATYPE_STRING = 1;
	public static final int DATATYPE_INTEGER = 2;
	public static final int DATATYPE_FLOAT = 3;
	public static final int DATATYPE_DATE = 4;
	public static final int DATATYPE_DICTIONARY = 5;
	public static final int DATATYPE_COMPLEX = 6;
	public static final int DATATYPE_ENUM = 7;//枚举类型
	
	public static final int RELATIONTYPE_ONE_TO_ONE=1;
	public static final int RELATIONTYPE_MANY_TO_MANY=2;
	public static final int RELATIONTYPE_ONE_TO_MANY=3;
	public static final int RELATIONTYPE_MANY_TO_ONE=4;
	
	public static final int VALIATETYPE_NONE=0;//无
	public static final int VALIATETYPE_EMAIL=1;//email 
	public static final int VALIATETYPE_NUMBER=2;//数字
	
	private Integer id;
	private Entity entity;//所属实体
	private String name;//意义名称
	private String propName;//在数据库表中对应的列的名称
	private String columnName;//列名称
	private String description;//备注
	private Integer length;//长度
	private Integer canNull=0;//默认不能为空，页面默认勾选“可以为空”项，不勾选时，使用此处默认0值
	private Integer dataType;//类别 1:字符串 2:整数 3:小数 4:日期  5:数据字典 6:复杂类型
	private String dictFix;//当bigType为5时，此处为对应的数据字典的前缀
	private String valuePath;//复杂类型字段值索取路径
	private String timeFormat;//时间类型格式
	private Integer sortValue;//排序 
	private Integer display=1;//是否列表显示
	private Integer forQuery=0;//是否可查询
	
	private Integer relationType=0;//复杂类型关联关系
	private Entity complexEntity;
	private Integer validateType;//验证方式
	
	private Integer isTotalRow=0;//占整行显示
	private Integer isTextArea=0;//在数据类型为整数的情况下，该值为1时表示是文本域
	private String setKeyCoumn;//一对多set中的key中的column值;一对多关联关系
	
	private Integer briefLength = 0;//简略显示长度
	
	private String row="3";//文本域的行数
	private String col="20";//文本域列数
	
	private Integer onlyRelationship=0;//为1时表示该字段仅仅是关联关系，不会在添加和修改页面中显示
	
	private Integer defaultSysTime=0;//默认系统时间
	private String enumValue;
	
	private String middletable;//多对多关联关系时的中间表
	
	private Integer isId = 0;//是否是主键
	private Integer isTextStringType;//text类型的字符串
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Entity getEntity() {
		return entity;
	}
	public void setEntity(Entity entity) {
		this.entity = entity;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPropName() {
		return propName;
	}
	public void setPropName(String propName) {
		this.propName = propName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getLength() {
		return length;
	}
	public void setLength(Integer length) {
		this.length = length;
	}
	public Integer getCanNull() {
		return canNull;
	}
	public void setCanNull(Integer canNull) {
		this.canNull = canNull;
	}
	public Integer getDataType() {
		return dataType;
	}
	public void setDataType(Integer dataType) {
		this.dataType = dataType;
	}
	public String getDictFix() {
		return dictFix;
	}
	public void setDictFix(String dictFix) {
		this.dictFix = dictFix;
	}
	public String getValuePath() {
		return valuePath;
	}
	public void setValuePath(String valuePath) {
		this.valuePath = valuePath;
	}
	public String getTimeFormat() {
		return timeFormat;
	}
	public void setTimeFormat(String timeFormat) {
		this.timeFormat = timeFormat;
	}
	public Integer getSortValue() {
		return sortValue;
	}
	public void setSortValue(Integer sortValue) {
		this.sortValue = sortValue;
	}
	public Integer getDisplay() {
		return display;
	}
	public void setDisplay(Integer display) {
		this.display = display;
	}
	public Integer getRelationType() {
		return relationType;
	}
	public void setRelationType(Integer relationType) {
		this.relationType = relationType;
	}
	public Entity getComplexEntity() {
		return complexEntity;
	}
	public void setComplexEntity(Entity complexEntity) {
		this.complexEntity = complexEntity;
	}
	public Integer getValidateType() {
		return validateType;
	}
	public void setValidateType(Integer validateType) {
		this.validateType = validateType;
	}
	public Integer getIsTotalRow() {
		return isTotalRow;
	}
	public void setIsTotalRow(Integer isTotalRow) {
		this.isTotalRow = isTotalRow;
	}
	public Integer getIsTextArea() {
		return isTextArea;
	}
	public void setIsTextArea(Integer isTextArea) {
		this.isTextArea = isTextArea;
	}
	public String getSetKeyCoumn() {
		return setKeyCoumn;
	}
	public void setSetKeyCoumn(String setKeyCoumn) {
		this.setKeyCoumn = setKeyCoumn;
	}
	public String getRow() {
		return row;
	}
	public void setRow(String row) {
		this.row = row;
	}
	public String getCol() {
		return col;
	}
	public void setCol(String col) {
		this.col = col;
	}
	public Integer getBriefLength() {
		return briefLength;
	}
	public void setBriefLength(Integer briefLength) {
		this.briefLength = briefLength;
	}
	public Integer getOnlyRelationship() {
		return onlyRelationship;
	}
	public void setOnlyRelationship(Integer onlyRelationship) {
		this.onlyRelationship = onlyRelationship;
	}
	public Integer getForQuery() {
		return forQuery;
	}
	public void setForQuery(Integer forQuery) {
		this.forQuery = forQuery;
	}
	public Integer getDefaultSysTime() {
		return defaultSysTime;
	}
	public void setDefaultSysTime(Integer defaultSysTime) {
		this.defaultSysTime = defaultSysTime;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getEnumValue() {
		return enumValue;
	}
	public void setEnumValue(String enumValue) {
		this.enumValue = enumValue;
	}
	public Integer getIsId() {
		return isId;
	}
	public void setIsId(Integer isId) {
		this.isId = isId;
	}
	public String getMiddletable() {
		return middletable;
	}
	public void setMiddletable(String middletable) {
		this.middletable = middletable;
	}
	
	/**
	 * 如果存在列名称则返回列名称，否则返回字段名称
	 * @return
	 */
	public String getColumnOrPropName(){
		return (this.getColumnName()!=null && !this.getColumnName().trim().equals(""))?this.getColumnName():this.getPropName().toLowerCase();
	}
	
	/**
	 * 根据字段获取字段类型名称
	 * @param prop
	 * @return
	 */
	public String getDataTypeName(){
		switch(getDataType().intValue()){
			case Property.DATATYPE_STRING:
				return "String";
			case Property.DATATYPE_INTEGER:
				return "Integer";
			case Property.DATATYPE_ENUM:
				return getComplexEntity().getClassName();
			case Property.DATATYPE_FLOAT:
				return "Float";
			case Property.DATATYPE_DATE:
				return "Date";
			case Property.DATATYPE_DICTIONARY:
				return "DictionaryDetail";
			case Property.DATATYPE_COMPLEX:
				if(this.getRelationType()==Property.RELATIONTYPE_ONE_TO_MANY){
					return "Set<"+getComplexEntity().getClassName()+">";
				}
				return getComplexEntity().getClassName();
		}
		return null;
	}
	public Integer getIsTextStringType() {
		return isTextStringType;
	}
	public void setIsTextStringType(Integer isTextStringType) {
		this.isTextStringType = isTextStringType;
	}
	
	public String getSetterName(){
		return "set"+this.getPropName().substring(0,1).toUpperCase()+this.getPropName().substring(1);
	}
	public String getGetterName(){
		return "get"+this.getPropName().substring(0,1).toUpperCase()+this.getPropName().substring(1);
	}
}
