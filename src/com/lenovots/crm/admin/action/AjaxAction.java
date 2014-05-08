package com.lenovots.crm.admin.action;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lenovots.crm.admin.entity.Operator;
import com.lenovots.crm.admin.service.IOperatorService;
import com.lenovots.crm.common.action.BaseAction;
import com.lenovots.crm.project.entity.Entity;
import com.lenovots.crm.project.entity.Packagee;
import com.lenovots.crm.project.entity.Property;
import com.lenovots.crm.project.service.IEntityService;
import com.lenovots.crm.project.service.IPackageService;
import com.lenovots.crm.project.service.IPropertyService;
import com.lenovots.crm.util.CommonUtil;




/**
 * @author 胡桥 2011-04-11
 */
@Controller("ajaxAction")
@Scope(value="prototype")
public class AjaxAction extends BaseAction<Operator> {
	
	@SuppressWarnings("unused")
	private static Logger logger = Logger.getLogger(AjaxAction.class);

	private static final long serialVersionUID = 1L;
	
	private String type;
	
	@Resource
	private IOperatorService operatorService;
	@Resource
	private IPackageService packageService;
	@Resource
	private IEntityService entityService;
	@Resource
	private IPropertyService propertyService;
	
	private String callRecordFileId;
	private Integer callResultId;
	
	private Integer isTaskTip;
	private Integer checkRate;
	
	private Integer propertyId;
	private Integer value;

	
	public String updateCanNull(){
		Property prop = propertyService.findById(propertyId);
		if(prop!=null){  
			prop.setCanNull(value);
			propertyService.update(prop);
		} 
		return null;
	}
	
	public String updateListDisplay(){
		Property prop = propertyService.findById(propertyId);
		if(prop!=null){
			prop.setDisplay(value);
			propertyService.update(prop);
		}
		return null;
	}
	
	
	/**
	 * 获取指定项目下的包
	 * @return
	 */
	public String getPackagesByProjectId(){
		List<Packagee> packages = new ArrayList<Packagee>();
		CommonUtil.tree(packageService.findByHql("FROM Packagee p WHERE p.project.id=? AND p.parent is null", new Object[]{id}), packages, "", null);
		StringBuffer result = new StringBuffer("[");
		for (Packagee pk : packages) {
			result.append("{id:'").append(pk.getId()).append("',name:'").append(pk.getName()).append("'},");
		}
		if(result.length()>1){
			result.delete(result.length()-1, result.length());
		}
		result.append("]");
		write(result.toString());
		return null;
	}
	/**
	 * 获取指定包下的实体
	 * @return
	 */
	public String getEntityByPackageId(){
		List<Entity> entityList = entityService.findByHql("FROM Entity e WHERE e.packagee.id=?", new Object[]{id});
		StringBuffer result = new StringBuffer("[");
		for (Entity en : entityList) {
			result.append("{id:'").append(en.getId()).append("',name:'").append(en.getFullClassName()).append("[").append(en.getName()).append("]").append("'},");
		}
		if(result.length()>1){
			result.delete(result.length()-1, result.length());
		}
		result.append("]");
		write(result.toString());
		return null;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getSubTypes() {
		String parent = ServletActionContext.getRequest().getParameter("parentId");
		int parentId = -1;
		if (parent != null)
			parentId = Integer.parseInt(parent);
		List<Packagee> packageeList = packageService.findByHql("from Packagee kt where kt.parent.id=?", new Object[] { parentId });
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/json; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		try {
			StringBuffer result = new StringBuffer("[");
			for (Packagee kt : packageeList) {
				if (result.length() > 1)
					result.append(",");
				result.append("{\"key\":\"" + kt.getId() + "\",\"title\":\"" + kt.getName() + "<a href='package_delete.action?ids="+kt.getId()+"'>删除</a>\",\"isLazy\":true}");
			}
			result.append("]");
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 记录样式类型
	 * @return
	 */
	public String recordStyleName(){
		try{
			ServletActionContext.getRequest().getSession().setAttribute("styleName",styleName);
			Operator operator=getOperator();
			if(operator!=null){
				operator.setStyleName(styleName);
				operatorService.update(operator);
				ServletActionContext.getRequest().getSession().setAttribute("OPERATOR", operator);
			}
			write("{success:false}");
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
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
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String getCheckCode() {
		// 设置浏览器不要缓存此图片
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");

		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache, must-revalidate");
		response.setDateHeader("Expires", 0);

		response.setContentType("image/jpeg");

		try {
			String code = getCode(6);
			outPutImage(response, code, 180, 30);
			ServletActionContext.getRequest().getSession().setAttribute("checkcode", code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 生成验证码
	 * 
	 * @param count
	 *            指定位数
	 * @return
	 */
	private String getCode(int count) {
		char[] base = "0123456789abcdefghijklmnopqrstuvwxyz".toCharArray();
		String result = "";
		for (int i = 0; i < count; i++) {
			int pos = new Random().nextInt(36);
			result += base[pos];
		}
		return result;
	}

	/**
	 * 向浏览器发送验证码
	 * 
	 * @param response
	 * @param code
	 * @param width
	 * @param height
	 * @throws IOException
	 */
	private void outPutImage(HttpServletResponse response, String code, int width, int height)
		throws IOException {
		OutputStream ops = response.getOutputStream();
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics g = image.getGraphics();
		// 验证码背景颜色
		g.setColor(new Color(19, 68, 108));
		g.fillRect(0, 0, width, height);
		// 写验证码
		int x = 2;
		char[] codes = code.toCharArray();
		 Color[]colors=new   Color[]{Color.red,Color.black,Color.green,Color.blue,Color.white,Color.yellow};
		for (int i = 0; i < codes.length; i++) {
			g.setFont(new Font("", Font.BOLD, 15+new Random().nextInt(15)));
			g.setColor(colors[new Random().nextInt(6)]);
			g.drawString(codes[i] + "", x, height - 2);
			x += width / codes.length;
		}
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(image, "jpg", baos);
		byte[] buf = baos.toByteArray();
		response.setContentLength(buf.length);
		ops.write(buf);
		baos.close();
		ops.close();
	}
	
	public String saveTipSet(){
		try{
			Operator operator=getOperator();
			if(operator!=null){
				operator.setIsTaskTip(isTaskTip);
				operator.setCheckRate(checkRate);
				operatorService.update(operator);
				ServletActionContext.getRequest().getSession().setAttribute("OPERATOR", operator);
			}
			write("{success:false}");
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public String getCallRecordFileId() {
		return callRecordFileId;
	}

	public void setCallRecordFileId(String callRecordFileId) {
		this.callRecordFileId = callRecordFileId;
	}

	public Integer getCallResultId() {
		return callResultId;
	}

	public void setCallResultId(Integer callResultId) {
		this.callResultId = callResultId;
	}

	public void setIsTaskTip(Integer isTaskTip) {
		this.isTaskTip = isTaskTip;
	}

	public void setCheckRate(Integer checkRate) {
		this.checkRate = checkRate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(Integer propertyId) {
		this.propertyId = propertyId;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
}
