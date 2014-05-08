<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@taglib prefix="s" uri="/struts-tags" %><%@page pageEncoding="UTF-8" %>package ${entity.fullPackageName};
${entity.classComment}
@Entity
<c:choose><c:when test="${not empty entity.tableName}">@Table(name="${entity.tableName}")</c:when><c:otherwise>@Table(name="t_${entity.lowerClassName}")</c:otherwise></c:choose>
public class ${entity.className}{

}