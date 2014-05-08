/*
Navicat MySQL Data Transfer

Source Server         : loalhost
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : codemaker_bpm

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2014-05-08 10:46:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `callsattribution`
-- ----------------------------
DROP TABLE IF EXISTS `callsattribution`;
CREATE TABLE `callsattribution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `cardType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of callsattribution
-- ----------------------------

-- ----------------------------
-- Table structure for `t_dept`
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phoneNumber1` varchar(255) DEFAULT NULL,
  `phoneNumber2` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `mainDeptId` int(11) DEFAULT NULL,
  `leaderId` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCB5BDF30359AA4D9` (`leaderId`) USING BTREE,
  KEY `FKCB5BDF30A8C3BC2F` (`mainDeptId`) USING BTREE,
  CONSTRAINT `t_dept_ibfk_1` FOREIGN KEY (`leaderId`) REFERENCES `t_operator` (`id`),
  CONSTRAINT `t_dept_ibfk_2` FOREIGN KEY (`mainDeptId`) REFERENCES `t_dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 16384 kB; (`leaderId`) REFER `crm_zsy/t_operato';

-- ----------------------------
-- Records of t_dept
-- ----------------------------
INSERT INTO `t_dept` VALUES ('15', '开发部', '', '', '', null, null, '', null);
INSERT INTO `t_dept` VALUES ('18', 'Novots', '', '', '', null, null, '', null);

-- ----------------------------
-- Table structure for `t_deskmodular`
-- ----------------------------
DROP TABLE IF EXISTS `t_deskmodular`;
CREATE TABLE `t_deskmodular` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `outSite` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `sortValue` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_deskmodular
-- ----------------------------

-- ----------------------------
-- Table structure for `t_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `t_dictionary`;
CREATE TABLE `t_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prefix` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dictionary
-- ----------------------------
INSERT INTO `t_dictionary` VALUES ('1', 'aaa', 'ccc', 'aaa');
INSERT INTO `t_dictionary` VALUES ('2', 'sex', '', '性别');
INSERT INTO `t_dictionary` VALUES ('3', 'logType', '', '日志类型');

-- ----------------------------
-- Table structure for `t_dictionarydetail`
-- ----------------------------
DROP TABLE IF EXISTS `t_dictionarydetail`;
CREATE TABLE `t_dictionarydetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `sortValue` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFEAB04F2DD172E8D` (`parentId`) USING BTREE,
  CONSTRAINT `t_dictionarydetail_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `t_dictionary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dictionarydetail
-- ----------------------------
INSERT INTO `t_dictionarydetail` VALUES ('1', '1', 'fdsafds', '11', '232');
INSERT INTO `t_dictionarydetail` VALUES ('2', '2', '男', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('3', '2', '女', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('4', '2', '未知', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('5', '3', '功能模块', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('6', '3', 'Bug修改', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('7', '3', '会议/计划', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('8', '3', '安装实施', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('9', '3', '系统演示', '', null);
INSERT INTO `t_dictionarydetail` VALUES ('10', '3', '文档编写', '', null);

-- ----------------------------
-- Table structure for `t_entity`
-- ----------------------------
DROP TABLE IF EXISTS `t_entity`;
CREATE TABLE `t_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `tableName` varchar(255) DEFAULT NULL,
  `className` varchar(255) DEFAULT NULL,
  `packageeId` int(11) DEFAULT NULL,
  `queryAble` int(11) DEFAULT NULL,
  `importable` int(11) DEFAULT NULL,
  `exportable` int(11) DEFAULT NULL,
  `visiablity` int(11) DEFAULT NULL,
  `idGenerateType` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `enumValue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6616360E35993495` (`packageeId`) USING BTREE,
  CONSTRAINT `t_entity_ibfk_1` FOREIGN KEY (`packageeId`) REFERENCES `t_package` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_entity
-- ----------------------------
INSERT INTO `t_entity` VALUES ('292', '员工', 'emp_employee', 'Employee', '72', '1', '0', '0', '1', '1', '0', '');
INSERT INTO `t_entity` VALUES ('293', '员工信息变更', 'emp_employee_alter', 'EmployeeAlter', '72', '0', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('294', '人事档案', 'emp_person_archive', 'PersonArchive', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('295', '人事档案类型', 'emp_person_archive_type', 'PersonArchiveType', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('296', '部门', 'emp_department', 'Department', '72', '1', '0', '0', '1', '1', '0', '');
INSERT INTO `t_entity` VALUES ('297', '职位', 'emp_position', 'Position', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('298', '职等', 'emp_vocation_level', 'VocationLevel', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('299', '职级', 'emp_position_rank', 'PositionRank', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('300', '员工属性', 'emp_employee_attribute', 'EmployeeAttribute', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('301', '用工类型', 'emp_employment_type', 'EmploymentType', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('302', '员工状态', 'emp_employee_status', 'EmployeeStatus', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('303', '工时', 'emp_man_hour', 'ManHour', '72', '0', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('304', '文件', 'sys_file', 'Filee', '78', '0', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('305', '文件夹', 'sys_common_folder', 'CommonFolder', '78', '0', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('306', '性别', '', 'Sex', '82', '0', '0', '0', '1', '0', '1', 'M=男;F=女');
INSERT INTO `t_entity` VALUES ('307', '是否', '', 'YesNo', '89', '0', '0', '0', '1', '0', '1', 'Yes=是;No=否');
INSERT INTO `t_entity` VALUES ('308', '离职类型', '', 'DimissType', '82', '0', '0', '0', '1', '0', '1', 'Active=主动;UnActive=被动');
INSERT INTO `t_entity` VALUES ('309', '离职原因', '', 'DimissReason', '82', '0', '0', '0', '1', '0', '1', 'DieOut=淘汰;Personal=个人因素;Fire=集团免职');
INSERT INTO `t_entity` VALUES ('310', '学历', '', 'Degree', '82', '0', '0', '0', '1', '0', '1', 'Doctor=博士;Master=硕士;College=本科;Junior=大专;Other=其它');
INSERT INTO `t_entity` VALUES ('311', '使用状态', '', 'UseStatus', '89', '0', '0', '0', '1', '0', '1', 'InUse=禁用;UnUse=使用');
INSERT INTO `t_entity` VALUES ('312', '等级类型', '', 'LevelType', '82', '0', '0', '0', '1', '0', '1', 'Mana=管理序列;Spec=专业序列');
INSERT INTO `t_entity` VALUES ('313', '工时类型', '', 'ManHourType', '82', '0', '0', '0', '1', '0', '1', 'Standard=标准工时;Colligate=综合工时;Indefinite=不定时');
INSERT INTO `t_entity` VALUES ('314', '用户', 'sys_user', 'User', '78', '1', '0', '0', '1', '1', '0', '');
INSERT INTO `t_entity` VALUES ('315', '角色', 'sys_role', 'Role', '78', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('316', '权限', 'sys_function_point', 'FunctionPoint', '78', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('317', '用户状态', '', 'UserStatus', '90', '0', '0', '0', '1', '0', '1', 'Active=活动;Approving=待审核;InActive=已禁止');
INSERT INTO `t_entity` VALUES ('318', '用户类型', '', 'UserType', '90', '0', '0', '0', '1', '0', '1', 'Local=本地;Domain=域用户');
INSERT INTO `t_entity` VALUES ('319', '工时时间', 'emp_man_hour_time', 'ManHourTime', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('320', '考勤', 'att_attendance', 'Attendance', '73', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('321', '考勤月度汇总', 'att_attendance_month_summary', 'AttendanceMonthSummary', '73', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('322', '工作日管理', 'att_working_day', 'WorkingDay', '73', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('323', '绩效评估', 'perf_performance_rule', 'PerformanceRule', '74', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('324', '绩效考核分数', 'perf_performance_score', 'PerformanceScore', '74', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('325', '工作计划', 'perf_work_plan', 'WorkPlan', '74', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('326', '人力资源', 'hr_resource', 'HrResource', '75', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('327', '人力资源库跟综日志', 'hr_resource_track_log', 'HrResourceTrackLog', '75', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('328', '课程', 'train_course', 'Course', '76', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('329', '日程', 'train_lesson', 'Lesson', '76', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('330', '学员群', 'train_trainee_group', 'TraineeGroup', '76', '1', '0', '1', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('331', '学员群人员', 'train_trainee_group_emp', 'TraineeGroupEmp', '76', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('332', '学员培训', 'train_lesson_trainee', 'LessonTrainee', '76', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('333', '招聘计划', 'recr_recruitment_plan', 'RecruitmentPlan', '77', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('334', '招聘计划状态', '', 'RecruitmentPlanStatus', '91', '0', '0', '0', '1', '0', '1', 'Recruiting=招聘中;Finish=已完成;Cancel=已取消');
INSERT INTO `t_entity` VALUES ('335', '日程状态', '', 'LessonStauts', '92', '0', '0', '0', '1', '0', '1', 'Normal=正常;Cancel=已取消');
INSERT INTO `t_entity` VALUES ('336', '工作计划状态', '', 'WorkPlanStatus', '93', '0', '0', '0', '1', '0', '1', 'Wait=待审核;Fail=未通过;Pass=通过');
INSERT INTO `t_entity` VALUES ('337', '考核周期类型', '', 'AppraisalCycleType', '93', '0', '0', '0', '1', '0', '1', 'Quarter=季度;Year=年度');
INSERT INTO `t_entity` VALUES ('338', '绩效评估类型', '', 'PerformanceRuleType', '93', '0', '0', '0', '1', '0', '1', 'Employee=员工;Leader=部门负责人');
INSERT INTO `t_entity` VALUES ('339', '工作日类型', '', 'WorkingDayType', '94', '0', '0', '0', '1', '0', '1', 'Work=工作日;Weekend=双休日;Holiday=法定假日');
INSERT INTO `t_entity` VALUES ('340', '考勤确认状态', '', 'AttendanceConfirmStatus', '94', '0', '0', '0', '1', '0', '1', 'Wait=待确认;True=属实;False=不属实');
INSERT INTO `t_entity` VALUES ('341', '绩效考核分数审批状态', '', 'PerformanceScoreApproveStatus', '93', '0', '0', '0', '1', '0', '1', 'Check=考核中;Finish=已完成;Complain=申诉');
INSERT INTO `t_entity` VALUES ('342', '绩效评估状态', '', 'PerformanceRuleStatus', '93', '0', '0', '0', '1', '0', '1', 'Wait=待审核;Fail=未通过;Pass=通过');
INSERT INTO `t_entity` VALUES ('343', '考核等级', 'zaAa', 'AssessmentGrade', '93', '0', '0', '0', '1', '0', '1', 'A=A;B=B;Bplus=B+;C=C;D=D');
INSERT INTO `t_entity` VALUES ('354', '人才类别', 'hr_hrcategory', 'HrCategory', '75', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('355', '员工修改类型', 'emp_updatetype', 'EmpUpdateType', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('356', '奖惩记录', 'emp_rewardpunishmentrecord', 'RewardPunishmentRecord', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('357', '年休假', 'emp_annualholiday', 'AnnualHoliday', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('358', '奖惩类型', '', 'RewardPunishmentRecType', '82', '0', '0', '0', '1', '0', '1', 'Reward=奖励;Punishment=惩罚');
INSERT INTO `t_entity` VALUES ('359', '学生', 't_student', 'Student', '72', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('360', '客户', 't_customer', 'Customer', '99', '1', '0', '0', '0', '1', '0', '');
INSERT INTO `t_entity` VALUES ('361', '认证记录', 'sso_authorization', 'SsoAuthorization', '101', '1', '0', '0', '0', '0', '0', '');
INSERT INTO `t_entity` VALUES ('362', '问答记录', 'talk_question_answer', 'QuestionAnswer', '103', '1', '0', '0', '0', '0', '0', '');
INSERT INTO `t_entity` VALUES ('363', '对话信息', 'talk_message', 'Message', '103', '1', '0', '0', '0', '0', '0', '');
INSERT INTO `t_entity` VALUES ('364', '历史聊天信息', 'talk_message_history', 'MessageHistory', '103', '1', '0', '0', '0', '0', '0', '');
INSERT INTO `t_entity` VALUES ('365', '会话', 'talk_session', 'TalkSession', '103', '1', '0', '0', '0', '0', '0', '');
INSERT INTO `t_entity` VALUES ('366', '用户', 'sys_user', 'User', '105', '1', '0', '0', '0', '0', '0', '');
INSERT INTO `t_entity` VALUES ('367', '用户反馈', 't_feedback', 'FeedBack', '103', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('503', '学生', 't_student', 'Student', '137', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('504', '教师', 't_teacher', 'Teacher', '137', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('505', '关键词', 't_word', 'Word', '142', '1', '0', '0', '1', '0', '0', '');
INSERT INTO `t_entity` VALUES ('506', '搜索结果', 't_search_result', 'SearchResult', '142', '1', '0', '0', '1', '0', '0', '');

-- ----------------------------
-- Table structure for `t_environmentvariable`
-- ----------------------------
DROP TABLE IF EXISTS `t_environmentvariable`;
CREATE TABLE `t_environmentvariable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `var_name` varchar(255) DEFAULT NULL,
  `var_value` varchar(255) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_environmentvariable
-- ----------------------------
INSERT INTO `t_environmentvariable` VALUES ('1', 'sql_menu_startId', '192', '2');

-- ----------------------------
-- Table structure for `t_job`
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO `t_job` VALUES ('3', '坐席', '系统默认', '0');
INSERT INTO `t_job` VALUES ('4', '管理员', '系统默认', '0');
INSERT INTO `t_job` VALUES ('9', '录入员', '', '1');

-- ----------------------------
-- Table structure for `t_knowledgetype`
-- ----------------------------
DROP TABLE IF EXISTS `t_knowledgetype`;
CREATE TABLE `t_knowledgetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `needCheck` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8D3EF44D35011E64` (`parentId`) USING BTREE,
  CONSTRAINT `t_knowledgetype_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `t_knowledgetype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_knowledgetype
-- ----------------------------

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext,
  `content` varchar(255) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `viewRange` varchar(255) DEFAULT NULL,
  `viewDeptNames` varchar(255) DEFAULT NULL,
  `publisher` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK757FE9031D64F9D2` (`publisher`) USING BTREE,
  CONSTRAINT `t_notice_ibfk_1` FOREIGN KEY (`publisher`) REFERENCES `t_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------

-- ----------------------------
-- Table structure for `t_operator`
-- ----------------------------
DROP TABLE IF EXISTS `t_operator`;
CREATE TABLE `t_operator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `visibility` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `deptId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `isCenter` int(11) DEFAULT NULL,
  `isMonitor` int(11) DEFAULT NULL,
  `isOnline` int(11) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `mobileNumber1` varchar(255) DEFAULT NULL,
  `mobileNumber2` varchar(255) DEFAULT NULL,
  `phoneNumber1` varchar(255) DEFAULT NULL,
  `phoneNumber2` varchar(255) DEFAULT NULL,
  `pop3Address` varchar(255) DEFAULT NULL,
  `smtpAddress` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mailPassword` varchar(255) DEFAULT NULL,
  `workNum` varchar(255) DEFAULT NULL,
  `workPwd` varchar(255) DEFAULT NULL,
  `signPwd` varchar(255) DEFAULT NULL,
  `jobId` int(11) DEFAULT NULL,
  `isTaskTip` int(11) DEFAULT NULL,
  `checkRate` int(11) DEFAULT NULL,
  `isSound` int(11) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `styleName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK98D69C0F2147A536` (`deptId`) USING BTREE,
  KEY `FK98D69C0F39BCE158` (`roleId`) USING BTREE,
  KEY `FK98D69C0F437C5264` (`jobId`) USING BTREE,
  KEY `FK98D69C0F6D4D60B9` (`roleId`) USING BTREE,
  CONSTRAINT `t_operator_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`),
  CONSTRAINT `t_operator_ibfk_2` FOREIGN KEY (`deptId`) REFERENCES `t_dept` (`id`),
  CONSTRAINT `t_operator_ibfk_3` FOREIGN KEY (`jobId`) REFERENCES `t_job` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 16384 kB; (`deptId`) REFER `crm_zsy/t_dept`(`id';

-- ----------------------------
-- Records of t_operator
-- ----------------------------
INSERT INTO `t_operator` VALUES ('1', 'admin', '系统管理员', '827ccb0eea8a706c4c34a16891f84e7b', 'self', null, '15', '1', '0', '0', null, '0', '13122221111', '', '', '', '', '', '', '', '110', '110', null, '4', '0', '300', '1', '5d8e0ec5-a7c7-4cc8-8592-e65a6d73ffe3.wav', 'start');

-- ----------------------------
-- Table structure for `t_package`
-- ----------------------------
DROP TABLE IF EXISTS `t_package`;
CREATE TABLE `t_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8B77277B1E6D6E8F` (`parentId`) USING BTREE,
  KEY `FK8B77277BC0B6E811` (`projectId`) USING BTREE,
  CONSTRAINT `t_package_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `t_package` (`id`),
  CONSTRAINT `t_package_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `t_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_package
-- ----------------------------
INSERT INTO `t_package` VALUES ('62', 'com', null, '10', '');
INSERT INTO `t_package` VALUES ('63', 'lenovots', '62', '10', '');
INSERT INTO `t_package` VALUES ('64', 'jdhr', '63', '10', '');
INSERT INTO `t_package` VALUES ('65', 'employee', '64', '10', '');
INSERT INTO `t_package` VALUES ('66', 'attendance', '64', '10', '');
INSERT INTO `t_package` VALUES ('67', 'performance', '64', '10', '');
INSERT INTO `t_package` VALUES ('68', 'hr', '64', '10', '');
INSERT INTO `t_package` VALUES ('69', 'train', '64', '10', '');
INSERT INTO `t_package` VALUES ('70', 'recruit', '64', '10', '');
INSERT INTO `t_package` VALUES ('71', 'system', '64', '10', '');
INSERT INTO `t_package` VALUES ('72', 'entity', '65', '10', '');
INSERT INTO `t_package` VALUES ('73', 'entity', '66', '10', '');
INSERT INTO `t_package` VALUES ('74', 'entity', '67', '10', '');
INSERT INTO `t_package` VALUES ('75', 'entity', '68', '10', '');
INSERT INTO `t_package` VALUES ('76', 'entity', '69', '10', '');
INSERT INTO `t_package` VALUES ('77', 'entity', '70', '10', '');
INSERT INTO `t_package` VALUES ('78', 'entity', '71', '10', '');
INSERT INTO `t_package` VALUES ('79', 'crm', '63', '10', '');
INSERT INTO `t_package` VALUES ('80', 'project', '79', '10', '');
INSERT INTO `t_package` VALUES ('81', 'entity', '80', '10', '');
INSERT INTO `t_package` VALUES ('82', 'enumtype', '72', '10', '');
INSERT INTO `t_package` VALUES ('83', 'demo', '63', '10', '');
INSERT INTO `t_package` VALUES ('84', 'test', '83', '10', '');
INSERT INTO `t_package` VALUES ('85', 'entity', '84', '10', '');
INSERT INTO `t_package` VALUES ('86', 'enumtype', '85', '10', '');
INSERT INTO `t_package` VALUES ('87', 'common', '64', '10', '');
INSERT INTO `t_package` VALUES ('88', 'entity', '87', '10', '');
INSERT INTO `t_package` VALUES ('89', 'enumtype', '88', '10', '');
INSERT INTO `t_package` VALUES ('90', 'enumtype', '78', '10', '');
INSERT INTO `t_package` VALUES ('91', 'enumtype', '77', '10', '');
INSERT INTO `t_package` VALUES ('92', 'enumtype', '76', '10', '');
INSERT INTO `t_package` VALUES ('93', 'enumtype', '74', '10', '');
INSERT INTO `t_package` VALUES ('94', 'enumtype', '73', '10', '');
INSERT INTO `t_package` VALUES ('95', 'com', null, '11', '');
INSERT INTO `t_package` VALUES ('96', 'lenovots', '95', '11', '');
INSERT INTO `t_package` VALUES ('97', 'smartit', '96', '11', '');
INSERT INTO `t_package` VALUES ('98', 'customer', '97', '11', '');
INSERT INTO `t_package` VALUES ('99', 'entity', '98', '11', '');
INSERT INTO `t_package` VALUES ('100', 'sso', '97', '11', '');
INSERT INTO `t_package` VALUES ('101', 'entity', '100', '11', '');
INSERT INTO `t_package` VALUES ('102', 'talk', '97', '11', '');
INSERT INTO `t_package` VALUES ('103', 'entity', '102', '11', '');
INSERT INTO `t_package` VALUES ('104', 'system', '97', '11', '');
INSERT INTO `t_package` VALUES ('105', 'entity', '104', '11', '');
INSERT INTO `t_package` VALUES ('135', 'com', null, '16', '');
INSERT INTO `t_package` VALUES ('136', 'test', '135', '16', '');
INSERT INTO `t_package` VALUES ('137', 'entity', '136', '16', '');
INSERT INTO `t_package` VALUES ('138', 'com', null, '15', '');
INSERT INTO `t_package` VALUES ('139', 'lenovots', '138', '15', '');
INSERT INTO `t_package` VALUES ('140', 'oa', '139', '15', '');
INSERT INTO `t_package` VALUES ('141', 'checker', '140', '15', '');
INSERT INTO `t_package` VALUES ('142', 'entity', '141', '15', '');

-- ----------------------------
-- Table structure for `t_pageproperty`
-- ----------------------------
DROP TABLE IF EXISTS `t_pageproperty`;
CREATE TABLE `t_pageproperty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskNodeId` int(11) DEFAULT NULL,
  `propertyId` int(11) DEFAULT NULL,
  `editable` int(11) DEFAULT NULL,
  `autovalue` int(11) DEFAULT NULL,
  `autoValueType` int(11) DEFAULT NULL,
  `valueOrExp` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK30D9074F66AAC1C0` (`taskNodeId`),
  KEY `FK30D9074FA523DBBC` (`propertyId`),
  CONSTRAINT `FK30D9074F66AAC1C0` FOREIGN KEY (`taskNodeId`) REFERENCES `t_tasknode` (`id`),
  CONSTRAINT `FK30D9074FA523DBBC` FOREIGN KEY (`propertyId`) REFERENCES `t_property` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_pageproperty
-- ----------------------------
INSERT INTO `t_pageproperty` VALUES ('90', '10', '7948', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('91', '10', '7949', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('92', '10', '7950', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('93', '10', '7951', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('94', '10', '7952', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('95', '10', '7953', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('96', '10', '7954', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('97', '10', '7955', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('98', '10', '7956', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('99', '10', '7957', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('100', '10', '7958', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('101', '10', '7959', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('102', '10', '7960', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('103', '10', '7961', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('104', '10', '7962', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('105', '10', '7963', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('106', '10', '7964', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('107', '10', '7965', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('108', '10', '7966', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('109', '10', '7967', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('110', '10', '7968', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('111', '10', '7969', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('112', '10', '7970', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('113', '10', '7971', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('114', '10', '7972', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('115', '10', '7973', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('116', '10', '7974', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('117', '10', '7975', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('118', '10', '7976', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('119', '10', '7977', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('120', '10', '7978', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('121', '10', '7979', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('122', '10', '7980', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('123', '10', '7981', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('124', '10', '7982', '0', null, null, null);
INSERT INTO `t_pageproperty` VALUES ('125', '10', '7983', '0', null, null, null);

-- ----------------------------
-- Table structure for `t_permission`
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `display` int(11) DEFAULT NULL,
  `sortValue` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9E830A7A1965D125` (`parentId`) USING BTREE,
  CONSTRAINT `t_permission_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `t_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1714 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 16384 kB; (`parentId`) REFER `crm_zsy/t_permiss';

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('864', '系统用户', 'operator_list.action', '893', 'func_199.jpg', '1', '864');
INSERT INTO `t_permission` VALUES ('865', '添加操作员', 'operator_add.action', '864', null, '1', '865');
INSERT INTO `t_permission` VALUES ('866', '修改操作员', 'operator_update.action', '864', null, '1', '866');
INSERT INTO `t_permission` VALUES ('867', '删除操作员', 'operator_delete.action', '864', null, '1', '867');
INSERT INTO `t_permission` VALUES ('872', '部门管理 ', 'department_list.action', '893', 'home.png', '1', '872');
INSERT INTO `t_permission` VALUES ('873', '添加处理部门', 'department_add.action', '872', null, '1', '873');
INSERT INTO `t_permission` VALUES ('874', '修改处理部门', 'department_update.action', '872', null, '1', '874');
INSERT INTO `t_permission` VALUES ('875', '删除处理部门', 'department_delete.action', '872', null, '1', '875');
INSERT INTO `t_permission` VALUES ('876', '职位维护', 'job_list.action', '893', 'Gnome-Preferences-Desktop-Accessibility-32.png', '1', '876');
INSERT INTO `t_permission` VALUES ('877', '添加职位', 'job_add.action', '876', null, '1', '877');
INSERT INTO `t_permission` VALUES ('878', '修改职位', 'job_update.action', '876', null, '1', '878');
INSERT INTO `t_permission` VALUES ('879', '删除职位', 'job_delete.action', '876', null, '1', '879');
INSERT INTO `t_permission` VALUES ('893', '系统设置', null, null, null, '1', '4');
INSERT INTO `t_permission` VALUES ('927', '角色管理', 'role_list.action', '893', 'Gnome-Dialog-Password-32.png', '1', '927');
INSERT INTO `t_permission` VALUES ('928', '添加角色', 'role_add.action', '927', null, '1', '928');
INSERT INTO `t_permission` VALUES ('929', '修改角色', 'role_update.action', '927', null, '1', '929');
INSERT INTO `t_permission` VALUES ('930', '删除角色', 'role_delete.action', '927', null, '1', '930');
INSERT INTO `t_permission` VALUES ('931', '权限配置', 'role_setPrivilege.action', '927', null, '1', '931');
INSERT INTO `t_permission` VALUES ('940', '菜单管理', 'permission_list.action', '893', 'func_16.jpg', '1', '940');
INSERT INTO `t_permission` VALUES ('1231', '数据字典', 'dictionary_list.action', '893', 'Gnome-Preferences-Desktop-Font-32.png', '1', '1231');
INSERT INTO `t_permission` VALUES ('1232', '添加数据字典', 'dictionary_add.action', '1231', 'default.gif', '1', '1232');
INSERT INTO `t_permission` VALUES ('1233', '修改数据字典', 'dictionary_update.action', '1231', 'default.gif', '1', '1233');
INSERT INTO `t_permission` VALUES ('1234', '删除数据字典', 'dictionary_delete.action', '1231', 'default.gif', '1', '1234');
INSERT INTO `t_permission` VALUES ('1235', '字典详情查看', 'dictionaryDetail_list.action', '1231', 'default.gif', '1', '1235');
INSERT INTO `t_permission` VALUES ('1236', '添加字典详情', 'dictionaryDetail_add.action', '1231', 'default.gif', '1', '1236');
INSERT INTO `t_permission` VALUES ('1237', '修改字典详情', 'dictionaryDetail_update.action', '1231', 'default.gif', '1', '1237');
INSERT INTO `t_permission` VALUES ('1239', '删除字典详情', 'dictionaryDetail_delete.action', '1231', 'default.gif', '1', '1239');
INSERT INTO `t_permission` VALUES ('1393', '基本设置', 'systemConfig_list.action', '893', 'Gnome-Applications-System-32.png', '1', '1393');
INSERT INTO `t_permission` VALUES ('1394', '修改基本设置', 'systemConfig_update.action', '1393', 'default.gif', '1', '1394');
INSERT INTO `t_permission` VALUES ('1406', '关于系统', 'about.jsp', '893', 'func_177.jpg', '1', '1406');
INSERT INTO `t_permission` VALUES ('1407', '菜单调整-上移', 'permission_up.action', '940', 'default.gif', '1', '1407');
INSERT INTO `t_permission` VALUES ('1408', '菜单调整-下移', 'permission_down.action', '940', 'default.gif', '1', '1408');
INSERT INTO `t_permission` VALUES ('1409', '添加菜单', 'permission_add.action', '940', 'default.gif', '1', '1409');
INSERT INTO `t_permission` VALUES ('1410', '修改菜单', 'permission_update.action', '940', 'default.gif', '1', '1410');
INSERT INTO `t_permission` VALUES ('1411', '删除菜单', 'permission_delete.action', '940', 'default.gif', '1', '1411');
INSERT INTO `t_permission` VALUES ('1562', '设置模块', 'role_setModular.action', '927', 'default.gif', '1', '932');
INSERT INTO `t_permission` VALUES ('1609', '项目管理', '', null, 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1610', '包管理', 'package_list.action', '1609', 'Gnome-Folder-32.png', '1', '1');
INSERT INTO `t_permission` VALUES ('1611', '添加包', 'package_add.action', '1610', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1612', '修改包', 'package_update.action', '1610', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1613', '删除包', 'package_delete.action', '1610', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1614', '实体管理', 'entity_list.action', '1609', 'Gnome-System-Log-Out-32.png', '1', '2');
INSERT INTO `t_permission` VALUES ('1615', '添加实体', 'entity_add.action', '1614', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1616', '修改实体', 'entity_update.action', '1614', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1617', '删除实体', 'entity_delete.action', '1614', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1618', '字段管理', 'property_list.action', '1609', 'Gnome-User-Desktop-32.png', '1', '3');
INSERT INTO `t_permission` VALUES ('1619', '字段添加', 'property_add.action', '1618', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1620', '字段修改', 'property_update.action', '1618', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1621', '字段删除', 'property_delete.action', '1618', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1622', '项目生成', 'project_build.action', '1632', 'Gnome-System-Software-Update-32.png', '1', '4');
INSERT INTO `t_permission` VALUES ('1632', '项目管理', 'project_list.action', '1609', 'func_188.jpg', '1', '5');
INSERT INTO `t_permission` VALUES ('1633', '删除项目', 'project_delete.action', '1632', 'default.gif', '1', '5');
INSERT INTO `t_permission` VALUES ('1634', '项目修改', 'project_update.action', '1632', 'default.gif', '1', '6');
INSERT INTO `t_permission` VALUES ('1635', '选定', 'project_select.action', '1632', 'default.gif', '1', '7');
INSERT INTO `t_permission` VALUES ('1636', '实体导入', 'entity_importExcelUI.action', '1614', 'default.gif', '1', '4');
INSERT INTO `t_permission` VALUES ('1637', '导入进度', 'entity_importProgress.action', '1614', 'default.gif', '1', '5');
INSERT INTO `t_permission` VALUES ('1638', '字段导入', 'property_importExcelUI.action', '1618', 'default.gif', '1', '4');
INSERT INTO `t_permission` VALUES ('1639', '导入进度', 'property_importProgress.action', '1618', 'default.gif', '1', '5');
INSERT INTO `t_permission` VALUES ('1640', '下载导入模版', 'property_exportEmptyExcel.action', '1618', 'default.gif', '1', '6');
INSERT INTO `t_permission` VALUES ('1641', '下载导入模版', 'entity_exportEmptyExcel.action', '1614', 'default.gif', '1', '6');
INSERT INTO `t_permission` VALUES ('1642', '更新记录', 'versionRecord_list.action', '1609', 'arrow_up_32.png', '1', '6');
INSERT INTO `t_permission` VALUES ('1643', '添加更新记录', 'versionRecord_add.action', '1642', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1644', '修改更新记录', 'versionRecord_update.action', '1642', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1645', '删除更新记录', 'versionRecord_delete.action', '1642', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1646', '添加项目', 'project_add.action', '1632', 'default.gif', '1', '8');
INSERT INTO `t_permission` VALUES ('1647', '工作流', '', null, 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1648', '报表/统计', '', null, 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1676', '标签管理', 'varLabel_list.action', '1609', 'Gnome-Insert-Text-32.png', '1', '7');
INSERT INTO `t_permission` VALUES ('1677', '添加标签', 'varLabel_add.action', '1676', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1678', '修改标签', 'varLabel_update.action', '1676', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1679', '删除标签', 'varLabel_delete.action', '1676', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1680', '模板管理', 'template_list.action', '1609', 'Gnome-Emblem-Documents-32.png', '1', '8');
INSERT INTO `t_permission` VALUES ('1681', '添加模板', 'template_add.action', '1680', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1682', '修改模板', 'template_update.action', '1680', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1683', '删除模板', 'template_delete.action', '1680', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1684', '代码预览', 'project_detail.action', '1632', 'default.gif', '1', '9');
INSERT INTO `t_permission` VALUES ('1685', '添加页面代码', 'entity_addPageCode.action', '1614', 'default.gif', '1', '7');
INSERT INTO `t_permission` VALUES ('1686', '修改页面代码', 'entity_updatePageCode.action', '1614', 'default.gif', '1', '8');
INSERT INTO `t_permission` VALUES ('1687', '列表页面代码', 'entity_listPageCode.action', '1614', 'default.gif', '1', '9');
INSERT INTO `t_permission` VALUES ('1688', 'Controller代码', 'entity_controllerCode.action', '1614', 'default.gif', '1', '10');
INSERT INTO `t_permission` VALUES ('1689', 'Service代码', 'entity_serviceCode.action', '1614', 'default.gif', '1', '11');
INSERT INTO `t_permission` VALUES ('1690', 'Service Impl代码', 'entity_serviceImplCode.action', '1614', 'default.gif', '1', '12');
INSERT INTO `t_permission` VALUES ('1691', 'Dao代码', 'entity_daoCode.action', '1614', 'default.gif', '1', '13');
INSERT INTO `t_permission` VALUES ('1692', 'Dao Impl代码', 'entity_daoPageCode.action', '1614', 'default.gif', '1', '14');
INSERT INTO `t_permission` VALUES ('1693', '模板组', 'templateGroup_list.action', '1609', 'folder_32.png', '1', '9');
INSERT INTO `t_permission` VALUES ('1694', '添加模板组', 'templateGroup_add.action', '1693', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1695', '修改模板组', 'templateGroup_update.action', '1693', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1696', '删除模板组', 'templateGroup_delete.action', '1693', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1697', '映射规则', 'rule_list.action', '1609', 'func_135.jpg', '1', '10');
INSERT INTO `t_permission` VALUES ('1698', '添加映射规则', 'rule_add.action', '1697', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1699', '修改映射规则', 'rule_update.action', '1697', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1700', '删除映射规则', 'rule_delete.action', '1697', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1701', '查看项目内容', 'project_viewFile.action', '1632', 'default.gif', '1', '10');
INSERT INTO `t_permission` VALUES ('1702', '删除项目代码', 'project_deleteCode.action', '1632', 'default.gif', '1', '11');
INSERT INTO `t_permission` VALUES ('1703', '查看文件内容', 'project_checkCode.action', '1632', 'default.gif', '1', '12');
INSERT INTO `t_permission` VALUES ('1704', '更新模板标签', 'template_refreshToFile.action', '1680', 'default.gif', '1', '4');
INSERT INTO `t_permission` VALUES ('1705', '文件下载', 'project_downloadFile.action', '1632', 'default.gif', '1', '13');
INSERT INTO `t_permission` VALUES ('1706', '节点任务管理', 'taskNode_list.action', '1647', 'func_40.jpg', '1', '1');
INSERT INTO `t_permission` VALUES ('1707', '添加节点任务', 'taskNode_add.action', '1706', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1708', '修改节点任务', 'taskNode_update.action', '1706', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1709', '删除节点任务', 'taskNode_delete.action', '1706', 'default.gif', '1', '3');
INSERT INTO `t_permission` VALUES ('1710', '环境变量', 'environmentVariable_list.action', '1609', 'func_15.jpg', '1', '11');
INSERT INTO `t_permission` VALUES ('1711', '添加环境变量', 'environmentVariable_add.action', '1710', 'default.gif', '1', '1');
INSERT INTO `t_permission` VALUES ('1712', '修改环境变量', 'environmentVariable_update.action', '1710', 'default.gif', '1', '2');
INSERT INTO `t_permission` VALUES ('1713', '删除环境变量', 'environmentVariable_delete.action', '1710', 'default.gif', '1', '3');

-- ----------------------------
-- Table structure for `t_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `outputDir` varchar(255) DEFAULT NULL,
  `templateDir` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_project
-- ----------------------------
INSERT INTO `t_project` VALUES ('10', '金地人力资源系统', 'D:\\test', 'E:\\Workspaces\\projectCreator4springMVC\\WebRoot\\WEB-INF\\template', '');
INSERT INTO `t_project` VALUES ('11', '智能IT服务平台', null, null, '');
INSERT INTO `t_project` VALUES ('12', '数智云模拟系统', null, null, '');
INSERT INTO `t_project` VALUES ('13', 'EIP模拟系统', null, null, '');
INSERT INTO `t_project` VALUES ('14', 'CASE模拟系统', null, null, '');
INSERT INTO `t_project` VALUES ('15', 'OA系统', null, null, '');
INSERT INTO `t_project` VALUES ('16', 'Test', null, null, '');

-- ----------------------------
-- Table structure for `t_project_envirvar`
-- ----------------------------
DROP TABLE IF EXISTS `t_project_envirvar`;
CREATE TABLE `t_project_envirvar` (
  `projectId` int(11) NOT NULL,
  `envirvar_Id` int(11) NOT NULL,
  PRIMARY KEY (`projectId`,`envirvar_Id`),
  KEY `FK40666B6234F29F6` (`projectId`),
  KEY `FK40666B62C85A94A1` (`envirvar_Id`),
  CONSTRAINT `FK40666B6234F29F6` FOREIGN KEY (`projectId`) REFERENCES `t_project` (`id`),
  CONSTRAINT `FK40666B62C85A94A1` FOREIGN KEY (`envirvar_Id`) REFERENCES `t_environmentvariable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_project_envirvar
-- ----------------------------
INSERT INTO `t_project_envirvar` VALUES ('10', '1');
INSERT INTO `t_project_envirvar` VALUES ('15', '1');

-- ----------------------------
-- Table structure for `t_project_rule`
-- ----------------------------
DROP TABLE IF EXISTS `t_project_rule`;
CREATE TABLE `t_project_rule` (
  `projectId` int(11) NOT NULL,
  `rule_Id` int(11) NOT NULL,
  PRIMARY KEY (`projectId`,`rule_Id`),
  KEY `FK131ED24D34F29F6` (`projectId`) USING BTREE,
  KEY `FK131ED24DD2C527F1` (`rule_Id`) USING BTREE,
  CONSTRAINT `t_project_rule_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `t_project` (`id`),
  CONSTRAINT `t_project_rule_ibfk_2` FOREIGN KEY (`rule_Id`) REFERENCES `t_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_project_rule
-- ----------------------------
INSERT INTO `t_project_rule` VALUES ('10', '5');
INSERT INTO `t_project_rule` VALUES ('11', '3');
INSERT INTO `t_project_rule` VALUES ('11', '4');
INSERT INTO `t_project_rule` VALUES ('11', '5');
INSERT INTO `t_project_rule` VALUES ('11', '6');
INSERT INTO `t_project_rule` VALUES ('11', '7');
INSERT INTO `t_project_rule` VALUES ('11', '8');
INSERT INTO `t_project_rule` VALUES ('11', '9');
INSERT INTO `t_project_rule` VALUES ('11', '10');
INSERT INTO `t_project_rule` VALUES ('11', '11');
INSERT INTO `t_project_rule` VALUES ('11', '12');
INSERT INTO `t_project_rule` VALUES ('11', '13');
INSERT INTO `t_project_rule` VALUES ('15', '14');
INSERT INTO `t_project_rule` VALUES ('15', '15');
INSERT INTO `t_project_rule` VALUES ('15', '16');
INSERT INTO `t_project_rule` VALUES ('15', '17');
INSERT INTO `t_project_rule` VALUES ('15', '18');
INSERT INTO `t_project_rule` VALUES ('15', '19');
INSERT INTO `t_project_rule` VALUES ('15', '20');
INSERT INTO `t_project_rule` VALUES ('15', '21');
INSERT INTO `t_project_rule` VALUES ('15', '22');
INSERT INTO `t_project_rule` VALUES ('15', '23');
INSERT INTO `t_project_rule` VALUES ('15', '24');
INSERT INTO `t_project_rule` VALUES ('15', '25');

-- ----------------------------
-- Table structure for `t_property`
-- ----------------------------
DROP TABLE IF EXISTS `t_property`;
CREATE TABLE `t_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `propName` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `canNull` int(11) DEFAULT NULL,
  `dataType` int(11) DEFAULT NULL,
  `dictFix` varchar(255) DEFAULT NULL,
  `valuePath` varchar(255) DEFAULT NULL,
  `timeFormat` varchar(255) DEFAULT NULL,
  `sortValue` int(11) DEFAULT NULL,
  `display` int(11) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `relationType` int(11) DEFAULT NULL,
  `complexId` int(11) DEFAULT NULL,
  `validateType` int(11) DEFAULT NULL,
  `isTotalRow` int(11) DEFAULT NULL,
  `isTextArea` int(11) DEFAULT NULL,
  `setKeyCoumn` varchar(255) DEFAULT NULL,
  `middleRelationTable` varchar(255) DEFAULT NULL,
  `row` varchar(255) DEFAULT NULL,
  `col` varchar(255) DEFAULT NULL,
  `briefLength` int(11) DEFAULT NULL,
  `onlyRelationship` int(11) DEFAULT NULL,
  `forQuery` int(11) DEFAULT NULL,
  `defaultSysTime` int(11) DEFAULT NULL,
  `columnName` varchar(255) DEFAULT NULL,
  `enumValue` varchar(255) DEFAULT NULL,
  `isId` int(11) DEFAULT NULL,
  `idGenerateType` int(11) DEFAULT NULL,
  `middletable` varchar(255) DEFAULT NULL,
  `isTextStringType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7B7A51405EE2D09D` (`entityId`) USING BTREE,
  KEY `FK7B7A5140888F522A` (`complexId`) USING BTREE,
  CONSTRAINT `t_property_ibfk_1` FOREIGN KEY (`entityId`) REFERENCES `t_entity` (`id`),
  CONSTRAINT `t_property_ibfk_2` FOREIGN KEY (`complexId`) REFERENCES `t_entity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8593 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_property
-- ----------------------------
INSERT INTO `t_property` VALUES ('7948', '员工编号', 'empNo', null, '20', '0', '1', null, '', '', '0', '1', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'emp_no', null, '1', null, '', '0');
INSERT INTO `t_property` VALUES ('7949', '名称', 'name', null, '20', '0', '1', null, '', '', '0', '1', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7950', '性别', 'sex', null, '0', '1', '7', null, '', '', '0', '1', '292', '0', '306', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'sex', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7951', '部门', 'department', null, '0', '0', '6', null, 'name', '', '0', '1', '292', '4', '296', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'department', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7952', '直接上级', 'superior', null, '0', '0', '6', null, 'name', '', '0', '1', '292', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'superior', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7953', '员工状态', 'stationStatus', null, '0', '0', '6', null, 'name', '', '0', '1', '292', '4', '302', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'station_status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7954', '职位名称', 'position', null, '0', '0', '6', null, 'name', '', '0', '1', '292', '4', '297', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'position', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7955', '任现职日期', 'currentPositionDate', null, '0', '0', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'current_position_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7956', '员工职等', 'vocationLevel', null, '0', '0', '6', null, 'name', '', '0', '1', '292', '4', '298', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'vocation_level', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7957', '员工属性', 'employeeAttribute', null, '0', '0', '6', null, 'name', '', '0', '1', '292', '4', '300', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'employee_attribute', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7958', '用工类型', 'employmentTtype', null, '0', '0', '6', null, 'name', '', '0', '1', '292', '4', '301', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'employment_type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7959', '是否毕业生', 'isGraduation', null, '0', '0', '7', null, '', '', '0', '0', '292', '0', '307', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'is_graduation', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7960', '出生日期', 'birthday', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'birthday', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7961', '年龄/岁', 'age', null, '0', '1', '3', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'age', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7962', '工作日期', 'firstWorkDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'first_work_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7963', '工龄/年', 'workAge', null, '0', '1', '3', null, '', '', '0', '1', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_age', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7964', '入司日期', 'joinDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'join_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7965', '司龄', 'joinAge', null, '0', '1', '3', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'join_age', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7966', '转正日期', 'regularDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'regular_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7967', '中文简历文件', 'resume', null, '0', '1', '6', null, 'name', '', '0', '0', '292', '4', '304', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'resume', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7968', '离职日期', 'dimissDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'dimiss_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7969', '离职类型', 'dimissType', null, '0', '1', '7', null, '', '', '0', '0', '292', '0', '308', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'dimiss_type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7970', '离职原因', 'dimissReason', null, '0', '1', '7', null, '', '', '0', '0', '292', '0', '309', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'dimiss_reason', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7971', '最高学历', 'highestDegree', null, '0', '1', '7', null, '', '', '0', '0', '292', '0', '310', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'highest_degree', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7972', '第一学历', 'firstDegree', null, '0', '1', '7', null, '', '', '0', '0', '292', '0', '310', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'first_degree', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7973', '所学专业', 'major', null, '50', '1', '1', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'major', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7974', '毕业学校', 'graduateSchool', null, '50', '1', '1', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'graduate_school', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7975', '毕业日期', 'graduateDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'graduate_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7976', '身份证号码', 'cardId', null, '30', '1', '1', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'cardId', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7977', '劳动合同开始时间', 'laborContractStartDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'labor_contract_start_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7978', '劳动合同终止时间', 'laborContractEndDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'labor_contract_end_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7979', '电话', 'telphone', null, '255', '1', '1', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'telphone', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7980', '邮箱', 'email', null, '255', '1', '1', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'email', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7981', '工时', 'manHour', null, '0', '1', '6', null, 'name', '', '0', '0', '292', '4', '303', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'man_hour', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7982', '管理', 'manageKey', null, '100', '1', '1', null, '', '', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'manage_key', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7983', '添加时间', 'createDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '292', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7984', '修改人', 'alterEmp', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'alter_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7985', '修改原因', 'alterReason', null, '0', '1', '1', null, '', '', '0', '0', '293', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'alter_reason', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('7986', '修改时间', 'alterTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'alter_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7987', '修改员工', 'employee', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'employee', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7988', '名称', 'name', null, '20', '0', '1', null, '', '', '0', '1', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7989', '性别', 'sex', null, '0', '1', '7', null, '', '', '0', '1', '293', '0', '306', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'sex', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7990', '部门', 'department', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '296', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'department', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7991', '直接上级', 'superior', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'superior', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7992', '员工状态', 'stationStatus', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '302', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'station_status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7993', '职位名称', 'position', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '297', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'position', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7994', '任现职日期', 'currentPositionDate', null, '0', '0', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'current_position_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7995', '员工职等', 'vocationLevel', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '298', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'vocation_level', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7996', '员工属性', 'employeeAttribute', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '300', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'employee_attribute', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7997', '用工类型', 'employmentTtype', null, '0', '0', '6', null, 'name', '', '0', '1', '293', '4', '301', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'employment_type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7998', '是否毕业生', 'isGraduation', null, '0', '0', '7', null, '', '', '0', '0', '293', '0', '307', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'is_graduation', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('7999', '出生日期', 'birthday', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'birthday', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8000', '年龄/岁', 'age', null, '0', '1', '3', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'age', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8001', '工作日期', 'firstWorkDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'first_work_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8002', '工龄/年', 'workAge', null, '0', '1', '3', null, '', '', '0', '1', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_age', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8003', '入司日期', 'joinDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'join_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8004', '司龄', 'joinAge', null, '0', '1', '3', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'join_age', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8005', '转正日期', 'regularDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'regular_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8006', '中文简历文件', 'resume', null, '0', '1', '6', null, 'name', '', '0', '0', '293', '4', '304', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'resume', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8007', '离职日期', 'dimissDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'dimiss_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8008', '离职类型', 'dimissType', null, '0', '1', '7', null, '', '', '0', '0', '293', '0', '308', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'dimiss_type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8009', '离职原因', 'dimissReason', null, '0', '1', '7', null, '', '', '0', '0', '293', '0', '309', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'dimiss_reason', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8010', '最高学历', 'highestDegree', null, '0', '1', '7', null, '', '', '0', '0', '293', '0', '310', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'highest_degree', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8011', '第一学历', 'firstDegree', null, '0', '1', '7', null, '', '', '0', '0', '293', '0', '310', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'first_degree', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8012', '所学专业', 'major', null, '50', '1', '1', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'major', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8013', '毕业学校', 'graduateSchool', null, '0', '1', '1', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'graduate_school', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8014', '毕业日期', 'graduateDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'graduate_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8015', '身份证号码', 'cardId', null, '30', '1', '1', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'cardId', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8016', '劳动合同开始时间', 'laborContractStartDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'labor_contract_start_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8017', '劳动合同终止时间', 'laborContractEndDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'labor_contract_end_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8018', '电话', 'telphone', null, '255', '1', '1', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'telphone', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8019', '邮箱', 'email', null, '255', '1', '1', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'email', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8020', '工时', 'manHour', null, '0', '1', '6', null, 'name', '', '0', '0', '293', '4', '303', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'man_hour', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8021', '管理', 'manageKey', null, '100', '1', '1', null, '', '', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'manage_key', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8022', '添加时间', 'createDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '0', '293', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8023', '工号', 'employee', null, '0', '0', '6', null, 'name', '', '0', '1', '294', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'employee', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8024', '档案类型', 'personArchiveType', null, '0', '0', '6', null, 'name', '', '0', '1', '294', '4', '295', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'person_archive_type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8025', '档案名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '294', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8026', '档案路径', 'archive', null, '0', '1', '6', null, 'name', '', '0', '0', '294', '4', '304', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'archive', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8027', '文件描述', 'archiveDesc', null, '0', '1', '1', null, '', '', '0', '0', '294', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'archive_desc', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8028', '创建日期', 'createTime', null, '0', '0', '4', null, '', 'yyyy-MM-dd', '0', '1', '294', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'create_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8029', '修改时间', 'alterTime', null, '0', '0', '4', null, '', 'yyyy-MM-dd', '0', '1', '294', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'alter_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8030', '修改员工', 'alterEmp', null, '0', '0', '6', null, 'name', '', '0', '1', '294', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'alter_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8031', '管理秘钥', 'manageKey', null, '100', '1', '1', null, '', '', '0', '0', '294', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'manage_key', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8032', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '295', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8033', '排序号', 'orderNum', null, '0', '0', '2', null, '', '', '0', '0', '295', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8034', '描述', 'description', null, '255', '1', '1', null, '', '', '0', '0', '295', '0', null, null, '1', '0', '', null, '10', '50', '0', '0', '0', '0', 'description', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8035', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '295', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8036', '部门编号', 'deptNo', null, '10', '0', '1', null, '', '', '0', '1', '296', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'dept_no', null, '1', null, '', '0');
INSERT INTO `t_property` VALUES ('8037', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '0', '296', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8038', '描述', 'description', null, '255', '1', '1', null, '', '', '0', '0', '296', '0', null, null, '1', '0', '', null, '10', '50', '0', '0', '0', '0', 'description', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8039', '负责人', 'leader', null, '0', '0', '6', null, 'name', '', '0', '1', '296', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'leader', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8040', '上级部门', 'parentDepartment', null, '0', '1', '6', null, 'name', '', '0', '1', '296', '4', '296', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'parent_department', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8041', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '296', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8042', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '297', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8043', '排序号', 'orderNum', null, '0', '1', '2', null, '', '', '0', '1', '297', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8044', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '297', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8045', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '298', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8046', '类别', 'type', null, '0', '1', '7', null, '', '', '0', '1', '298', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8047', '职级', 'position_rank', null, '0', '0', '6', null, 'name', '', '0', '1', '298', '4', '299', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'position_rank', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8048', '排序', 'order_num', null, '0', '10', '2', null, '', '', '0', '0', '298', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8049', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '298', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8050', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '299', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8051', '排序号', 'orderNum', null, '0', '1', '2', null, '', '', '0', '1', '299', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8052', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '299', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8053', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '300', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8054', '排序号', 'orderNum', null, '0', '1', '2', null, '', '', '0', '1', '300', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8055', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '300', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8056', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '301', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8057', '排序号', 'orderNum', null, '0', '1', '2', null, '', '', '0', '1', '301', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8058', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '301', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8059', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '302', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8060', '排序号', 'orderNum', null, '0', '1', '2', null, '', '', '0', '1', '302', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8061', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '302', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8062', '名称', 'name', null, '20', '0', '1', null, '', '', '0', '1', '303', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8063', '类型', 'type', null, '0', '1', '7', null, '', '', '0', '1', '303', '0', '313', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8064', '排序', 'orderNum', null, '0', '0', '2', null, '', '', '0', '0', '303', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8065', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '303', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8066', '文件名称', 'name', null, '100', '0', '1', null, '', '', '0', '1', '304', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8067', '存储', 'storeName', null, '100', '1', '1', null, '', '', '0', '1', '304', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'store_name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8068', '扩展名', 'extensionName', null, '20', '1', '1', null, '', '', '0', '1', '304', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'extension_name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8069', '创建时间', 'createDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '304', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8070', '所属文件夹', 'folder', null, '0', '0', '6', null, 'folderName', '', '0', '1', '304', '4', '305', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'folder', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8071', '管理', 'manageKey', null, '100', '1', '1', null, '', '', '0', '1', '304', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'manage_key', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8072', '文件夹名', 'folderName', null, '100', '0', '1', null, '', '', '0', '1', '305', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'folder_name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8073', '存储路径', 'storePath', null, '100', '0', '1', null, '', '', '0', '1', '305', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'store_path', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8074', '用户名', 'userName', null, '20', '0', '1', null, '', '', '0', '1', '314', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'username', null, '1', null, '', '0');
INSERT INTO `t_property` VALUES ('8075', '密码', 'password', null, '100', '0', '1', null, '', '', '0', '1', '314', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'password', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8076', '所属员工', 'emp', null, '0', '0', '6', null, 'name', '', '0', '1', '314', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'emp_no', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8077', '状态', 'status', null, '0', '0', '7', null, '', '', '0', '1', '314', '0', '317', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8078', '类型', 'type', null, '0', '1', '7', null, '', '', '0', '1', '314', '0', '318', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8079', '角色', 'roles', null, '0', '0', '6', null, '', '', '0', '0', '314', '2', '315', null, '0', '0', '', null, '', '', '0', '1', '0', '0', '', null, '0', null, 's_user_role', '0');
INSERT INTO `t_property` VALUES ('8080', '权限范围', 'departments', null, '0', '0', '6', null, '', '', '0', '0', '314', '2', '296', null, '0', '0', '', null, '', '', '0', '1', '0', '0', '', null, '0', null, 's_user_right_scope', '0');
INSERT INTO `t_property` VALUES ('8081', '名称', 'name', null, '100', '0', '1', null, '', '', '0', '1', '315', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8082', '描述', 'description', null, '255', '1', '1', null, '', '', '0', '0', '315', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'description', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8083', '权限', 'functionPoints', null, '0', '1', '6', null, '', '', '0', '0', '315', '2', '316', null, '0', '0', '', null, '', '', '0', '1', '0', '0', '', null, '0', null, 's_role_function_point', '0');
INSERT INTO `t_property` VALUES ('8084', '名称', 'name', null, '255', '0', '1', null, '', '', '0', '1', '316', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8085', '功能路径', 'url', null, '255', '1', '1', null, '', '', '0', '1', '316', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'url', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8086', '图标', 'icon', null, '255', '1', '1', null, '', '', '0', '1', '316', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'icon', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8087', '页面可见', 'isDisplay', null, '0', '0', '2', null, '', '', '0', '1', '316', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'is_display', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8088', '排序号', 'orderNum', null, '0', '0', '2', null, '', '', '0', '1', '316', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8089', '上级', 'parent', null, '0', '1', '6', null, 'name', '', '0', '1', '316', '4', '316', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'parent', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8090', '工时', 'manHour', null, '0', '0', '6', null, 'name', '', '0', '1', '319', '4', '303', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'man_hour', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8091', '上班时段', 'standBeginTime', null, '40', '0', '1', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '319', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'stand_begin_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8092', '下班时段', 'standEndTime', null, '40', '0', '1', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '319', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'stand_end_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8093', '工号', 'empNo', null, '0', '0', '6', null, 'name', '', '0', '1', '320', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'emp_no', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8094', '部门', 'department', null, '0', '0', '6', null, 'name', '', '0', '1', '320', '4', '296', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'department', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8095', '工时', 'manHour', null, '0', '0', '6', null, 'name', '', '0', '1', '320', '4', '303', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'man_hour', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8096', '上班时间', 'beginTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'begin_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8097', '下班时间', 'endTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'end_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8098', '工作小时数', 'workHour', null, '0', '1', '3', null, '', '', '0', '1', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_hour', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8099', '标准上班时间', 'standBeginTime', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'stand_begin_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8100', '标准下班时间', 'standEndTime', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'stand_end_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8101', '加班', 'isWorkExtra', null, '0', '1', '7', null, '', '', '0', '0', '320', '0', '307', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'is_work_extra', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8102', '个人备注', 'personNote', null, '255', '1', '1', null, '', '', '0', '0', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'person_note', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8103', '备注时间', 'personNoteTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'person_note_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8104', '备注修改时间', 'personNoteModifyTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'person_note_modify_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8105', '确认人', 'confirmEmp', null, '0', '1', '6', null, 'name', '', '0', '0', '320', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'confirm_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8106', '确认时间', 'confirmTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '320', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'confirm_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8107', '状态', 'confirmStatus', null, '0', '1', '7', null, '', '', '0', '1', '320', '0', '340', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'confirm_status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8108', '考勤月份', 'attendanceMonth', null, '0', '0', '4', null, '', 'yyyy-MM', '0', '1', '321', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'attendance_month', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8109', '员工', 'empNo', null, '0', '0', '6', null, 'name', '', '0', '1', '321', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'emp_no', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8110', '在岗天数', 'workDay', null, '0', '1', '3', null, '', '', '0', '1', '321', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_day', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8111', '迟到小时数', 'larriveLateHour', null, '0', '1', '3', null, '', '', '0', '1', '321', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', ']arrive_late_hour', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8112', '早退小时数：', 'leaveEarlyHour ', null, '0', '1', '3', null, '', '', '0', '1', '321', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'leave_early_hour ', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8113', '旷工天数：', 'absenceDay', null, '0', '1', '3', null, '', '', '0', '1', '321', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'absence_day', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8114', '加班次数', 'workExtraTimes', null, '0', '1', '3', null, '', '', '0', '1', '321', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_extra_times', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8115', '修改说明：', 'modifyDesc', null, '255', '0', '1', null, '', '', '0', '0', '321', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'modify_desc', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8116', '修改人', 'modifyEmp', null, '0', '1', '6', null, 'name', '', '0', '1', '321', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'modify_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8117', '类型', 'type', null, '0', '0', '7', null, '', '', '0', '1', '322', '0', '339', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8118', '备注', 'note', null, '100', '1', '1', null, '', '', '0', '0', '322', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'note', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8119', '当天考勤是否已检查', 'isAttendanceChecked', null, '0', '0', '7', null, '', '', '0', '0', '322', '0', '307', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'is_attendance_checked', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8120', '创建员工', 'createEmp', null, '0', '0', '6', null, 'name', '', '0', '1', '323', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'create_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8121', '提交时所处部门', 'department', null, '0', '0', '6', null, 'name', '', '0', '0', '323', '4', '296', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'department', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8122', '提交时职位名称', 'position', null, '0', '1', '6', null, 'name', '', '0', '0', '323', '4', '297', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'position', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8123', '提交时员工职等', 'vocationLevel', null, '0', '1', '6', null, 'name', '', '0', '0', '323', '4', '298', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'vocation_level', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8124', '提交时间', 'createTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'create_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8125', '修改时间', 'modifyTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'modify_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8126', '类型', 'type', null, '0', '0', '7', null, '', '', '0', '0', '323', '0', '338', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8127', '考核因素1', 'factor1', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8128', '指标值1', 'factor1Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor1_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8129', '权重1', 'weight1', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8130', '考核因素2', 'factor2', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8131', '指标值2', 'factor2Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor2_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8132', '权重2', 'weight2', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8133', '考核因素3', 'factor3', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8134', '指标值3', 'factor3Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor3_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8135', '权重3', 'weight3', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8136', '考核因素4', 'factor4', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor4', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8137', '指标值4', 'factor4Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor4_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8138', '权重4', 'weight4', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight4', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8139', '考核因素5', 'factor5', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor5', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8140', '指标值5', 'factor5Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor5_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8141', '权重5', 'weight5', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight5', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8142', '考核因素6', 'factor6', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor6', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8143', '指标值6', 'factor6Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor6_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8144', '权重6', 'weight6', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight6', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8145', '考核因素7', 'factor7', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor7', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8146', '指标值7', 'factor7Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor7_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8147', '权重7', 'weight7', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight7', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8148', '考核因素8', 'factor8', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor8', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8149', '指标值8', 'factor8Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor8_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8150', '权重8', 'weight8', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight8', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8151', '考核因素9', 'factor9', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor9', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8152', '指标值9', 'factor9Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor9_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8153', '权重9', 'weight9', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight9', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8154', '考核因素10', 'factor10', null, '255', '1', '1', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor10', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8155', '指标值10', 'factor10Value', null, '0', '0', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'factor10_value', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8156', '权重10', 'weight10', null, '0', '1', '2', null, '', '', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight10', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8157', '附件', 'attachFile', null, '0', '1', '6', null, 'name', '', '0', '1', '323', '4', '304', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'attach_file', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8158', '考核周期', 'appraisalCycle', null, '0', '1', '7', null, '', '', '0', '1', '323', '0', '337', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'appraisal_cycle', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8159', '备注', 'notation', null, '0', '1', '1', null, '', '', '0', '0', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'notation', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8160', '审核人', 'approveEmp', null, '0', '1', '6', null, 'name', '', '0', '1', '323', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'approve_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8161', '审核时间', 'approveTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '323', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'approve_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8162', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '323', '0', '342', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8163', '审核意见', 'appvoeSuggest', null, '0', '1', '1', null, '', '', '0', '0', '323', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'appvoe_suggest', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8164', '绩效评估', 'performanceRule', null, '0', '0', '6', null, 'name', '', '0', '0', '324', '4', '324', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'performance_rule', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8165', '考核月份', 'performanceMonth', null, '0', '0', '4', null, '', 'yyyy-MM-dd', '0', '1', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'performance_month', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8166', '自评考核因素1完成情况', 'finish1Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish1_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8167', '自评考核因素2完成情况', 'finish2Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish2_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8168', '自评考核因素3完成情况', 'finish3Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish3_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8169', '自评考核因素4完成情况', 'finish4Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish4_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8170', '自评考核因素5完成情况', 'finish5Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish5_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8171', '自评考核因素6完成情况', 'finish6Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish6_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8172', '自评考核因素7完成情况', 'finish7Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish7_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8173', '自评考核因素8完成情况', 'finish8Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish8_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8174', '自评考核因素9完成情况', 'finish9Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish9_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8175', '自评考核因素10完成情况', 'finish10Self', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish10_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8176', '考核因素1自评分', 'score1Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score1_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8177', '考核因素2自评分', 'score2Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score2_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8178', '考核因素3自评分', 'score3Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score3_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8179', '考核因素4自评分', 'score4Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score4_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8180', '考核因素5自评分', 'score5Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score5_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8181', '考核因素6自评分', 'score6Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score6_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8182', '考核因素7自评分', 'score7Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score7_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8183', '考核因素8自评分', 'score8Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score8_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8184', '考核因素9自评分', 'score9Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score9_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8185', '考核因素10自评分', 'score10Self', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score10_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8186', '自我评价', 'assessSelf', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'assess_self', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8187', '自评时间', 'createTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8188', '初审人', 'leader1', null, '0', '1', '6', null, '', '', '0', '0', '324', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8189', '初审人评分1评分', 'score1Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score1_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8190', '初审人评分2评分', 'score2Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score2_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8191', '初审人评分3评分', 'score3Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score3_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8192', '初审人评分4评分', 'score4Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score4_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8193', '初审人评分5评分', 'score5Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score5_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8194', '初审人评分6评分', 'score6Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score6_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8195', '初审人评分7评分', 'score7Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score7_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8196', '初审人评分8评分', 'score8Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score8_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8197', '初审人评分9评分', 'score9Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score9_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8198', '初审人评分10评分', 'score10Leader1', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score10_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8199', '初审人考核等级', 'gradeLeader1', null, '0', '1', '7', null, '', '', '0', '1', '324', '0', '343', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'grade_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8200', '初审人考核评价', 'assessLeader1', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'assess_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8201', '初审时间', 'assessTimeLeader1', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'assess_time_leader1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8202', '复审人', 'leader2', null, '0', '1', '6', null, '', '', '0', '0', '324', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8203', '复审人人评分1', 'score1Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score1_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8204', '复审人人评分2', 'score2Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score2_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8205', '复审人人评分3', 'score3Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score3_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8206', '复审人人评分4', 'score4Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score4_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8207', '复审人人评分5', 'score5Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score5_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8208', '复审人人评分6', 'score6Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score6_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8209', '复审人人评分7', 'score7Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score7_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8210', '复审人人评分8', 'score8Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score8_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8211', '复审人人评分9', 'score9Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score9_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8212', '复审人人评分10', 'score10Leader2', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score10_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8213', '复审人考核等级1', 'gradeLeader2', null, '0', '1', '7', null, '', '', '0', '1', '324', '0', '343', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'grade_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8214', '复审人考核评价', 'assessLeader2', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'assess_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8215', '复审时间', 'assessTimeLeader2', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'assess_time_leader2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8216', '终审人', 'leader3', null, '0', '1', '6', null, '', '', '0', '0', '324', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8217', '终审人人评分1', 'score1Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score1_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8218', '终审人人评分2', 'score2Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score2_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8219', '终审人人评分3', 'score3Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score3_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8220', '终审人人评分4', 'score4Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score4_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8221', '终审人人评分5', 'score5Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score5_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8222', '终审人人评分6', 'score6Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score6_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8223', '终审人人评分7', 'score7Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score7_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8224', '终审人人评分8', 'score8Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score8_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8225', '终审人人评分9', 'score9Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score9_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8226', '终审人人评分10', 'score10Leader3', null, '0', '1', '2', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score10_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8227', '终审人考核等级', 'gradeLeader3', null, '0', '1', '7', null, '', '', '0', '1', '324', '0', '343', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'grade_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8228', '终审人考核评价', 'assessLeader3', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'assess_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8229', '终审时间', 'assessTimeLeader3', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'assess_time_leader3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8230', '面谈时间', 'interviewTime', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'interview_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8231', '出色的工作', 'excellentWork', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'excellent_work', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8232', '待提高的工作', 'needImproveWork', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'need_improve_work', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8233', '综合能力项描述', 'allAbilityItem', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'all_ability_item', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8234', '上级期望努力领域', 'hopeScopeLeader', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'hope_scope_leader', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8235', '上级期望综合能力提高方面', 'hopeAbilityLeader', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'hope_ability_leader', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8236', '上级其他方面', 'hopeOtherLeader', null, '255', '1', '1', null, '', '', '0', '0', '324', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'hope_other_leader', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8237', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '324', '0', '341', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8238', '工号', 'empNo', null, '0', '1', '6', null, '', '', '0', '0', '325', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'emp_no', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8239', '计划月', 'planMonth', null, '0', '0', '4', null, '', 'yyyy-MM-dd', '0', '1', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'plan_month', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8240', '工作事项1', 'workItem1', null, '200', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_item1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8241', '工作内容描述1', 'workContent1', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'work_content1', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8242', '权重1', 'weight1', null, '0', '1', '2', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight1', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8243', '完成情况自述1', 'finishDesc1', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'finish_desc1', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8244', '备注1', 'note1', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'note1', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8245', '工作事项2', 'workItem2', null, '200', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_item2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8246', '工作内容描述2', 'workContent2', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'work_content2', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8247', '权重2', 'weight2', null, '0', '1', '2', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight2', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8248', '完成情况自述2', 'finishDesc2', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'finish_desc2', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8249', '备注2', 'note2', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'note2', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8250', '工作事项3', 'workItem3', null, '200', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_item3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8251', '工作内容描述3', 'workContent3', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'work_content3', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8252', '权重3', 'weight3', null, '0', '1', '2', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight3', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8253', '完成情况自述3', 'finishDesc3', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'finish_desc3', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8254', '备注3', 'note3', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'note3', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8255', '工作事项4', 'workItem4', null, '200', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_item4', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8256', '工作内容描述4', 'workContent4', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'work_content4', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8257', '权重4', 'weight4', null, '0', '1', '2', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight4', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8258', '完成情况自述4', 'finishDesc4', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'finish_desc4', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8259', '备注4', 'note4', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'note4', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8260', '工作事项5', 'workItem5', null, '200', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'work_item5', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8261', '工作内容描述5', 'workContent5', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'work_content5', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8262', '权重5', 'weight5', null, '0', '1', '2', null, '', '', '0', '0', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'weight5', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8263', '完成情况自述5', 'finishDesc5', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'finish_desc5', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8264', '备注5', 'note5', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'note5', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8265', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '325', '0', '336', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8266', '审核人', 'approveEmp', null, '0', '1', '6', null, '', '', '0', '1', '325', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'approve_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8267', '审核时间', 'approveTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '325', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'approve_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8268', '针对工作计划意见', 'approveSuggest', null, '0', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'approve_suggest', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8269', '管理', 'manageKey', null, '100', '1', '1', null, '', '', '0', '0', '325', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'manage_key', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8270', '姓名', 'name', null, '20', '1', '1', null, '', '', '0', '1', '326', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8271', '性别', 'sex', null, '0', '1', '7', null, '', '', '0', '1', '326', '0', '306', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'sex', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8272', '身份证', 'cardId', null, '30', '1', '1', null, '', '', '0', '0', '326', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'cardId', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8273', '手机号', 'phone', null, '30', '1', '1', null, '', '', '0', '0', '326', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'phone', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8274', '应聘职位', 'position', null, '0', '1', '6', null, '', '', '0', '1', '326', '4', '297', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'position', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8275', '简历文件', 'resume', null, '0', '1', '6', null, 'name', '', '0', '0', '326', '4', '304', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'resume', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8276', '添加人', 'createEmp', null, '0', '1', '6', null, 'name', '', '0', '1', '326', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8277', '添加日期', 'createTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '326', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8278', '最后跟踪人', 'lastTrackEmp', null, '0', '1', '6', null, 'name', '', '0', '1', '326', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'last_track_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8279', '最后跟踪日期', 'lastTrackTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '326', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'last_track_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8280', '跟踪人力库', 'hrResource', null, '0', '0', '6', null, 'name', '', '0', '0', '327', '4', '326', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'hr_resource', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8281', '跟踪人', 'trackEmp', null, '0', '1', '6', null, 'name', '', '0', '1', '327', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'track_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8282', '跟踪日期', 'tarckTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '1', '327', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'tarck_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8283', '跟踪结果', 'result', null, '0', '1', '1', null, '', '', '0', '0', '327', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'result', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8284', '课程名称', 'name', null, '100', '1', '1', null, '', '', '0', '1', '328', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8285', '添加日期', 'createDate', null, '0', '1', '4', null, '', 'yyyy-MM-dd', '0', '1', '328', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8286', '添加人', 'createEmp', null, '0', '1', '6', null, 'name', '', '0', '1', '328', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'create_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8287', '培训机构', 'trainOrg', null, '100', '0', '1', null, '', '', '0', '1', '328', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'train_org', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8288', '负责人', 'owner', null, '0', '1', '6', null, 'name', '', '0', '1', '328', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'owner', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8289', '人均培训费用', 'costPerTrainee', null, '0', '1', '2', null, '', '', '0', '1', '328', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'cost_per_trainee', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8290', '课程内容', 'courseContent', null, '0', '1', '1', null, '', '', '0', '0', '328', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'course_content', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8291', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '328', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8292', '课程', 'course', null, '0', '0', '6', null, 'name', '', '0', '1', '329', '4', '328', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'course', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8293', '开始时间', 'startTime', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '329', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'start_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8294', '结束时间', 'endTime', null, '0', '0', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '329', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'end_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8295', '日程名称', 'lessonName', null, '50', '1', '1', null, '', '', '0', '1', '329', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'lesson_name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8296', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '0', '329', '0', '335', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8297', '满意度', 'satisfactionScore', null, '0', '1', '3', null, '', '', '0', '1', '329', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'satisfaction_score', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8298', '授课地点', 'place', null, '100', '1', '1', null, '', '', '0', '1', '329', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'place', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8299', '课时', 'courseHour', null, '0', '1', '3', null, '', '', '0', '1', '329', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'course_hour', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8300', '课程讲师', 'lessonTrainer', null, '0', '1', '6', null, 'name', '', '0', '1', '329', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'lesson_trainer', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8301', '联系方式', 'contact', null, '100', '1', '1', null, '', '', '0', '1', '329', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'contact', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8302', '日程介绍', 'lessonContent', null, '0', '1', '1', null, '', '', '0', '0', '329', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'lesson_content', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8303', '注意事项', 'attention', null, '0', '1', '1', null, '', '', '0', '0', '329', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'attention', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8304', '群组名称', 'name', null, '30', '1', '1', null, '', '', '0', '1', '330', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8305', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '330', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8306', '备注', 'note', null, '0', '1', '1', null, '', '', '0', '0', '330', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'note', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8307', '群组', 'traineeGroup', null, '0', '0', '6', null, 'name', '', '0', '1', '331', '4', '330', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'trainee_group', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8308', '学员', 'trainee', null, '0', '0', '6', null, 'name', '', '0', '1', '331', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'trainee', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8309', '备注', 'note', null, '0', '1', '1', null, '', '', '0', '0', '331', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'note', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8310', '日程', 'lesson', null, '0', '0', '6', null, 'name', '', '0', '1', '332', '4', '329', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'lesson', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8311', '参训人员', 'trainEmp', null, '0', '0', '6', null, 'name', '', '0', '1', '332', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'train_emp', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8312', '是否已评分', 'is_score', null, '0', '1', '7', null, '', '', '0', '1', '332', '0', '307', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'is_score', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8313', '评分', 'givenScore', null, '0', '1', '2', null, '', '', '0', '1', '332', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'given_score', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8314', '评价内容', 'assessContent', null, '0', '1', '1', null, '', '', '0', '0', '332', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'assess_content', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8315', '报名时间', 'bookTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '332', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'book_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8316', '评分时间', 'scoreTime', null, '0', '1', '4', null, '', 'yyyy-MM-dd HH:mm:ss', '0', '0', '332', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'score_time', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8317', '部门', 'department', null, '0', '0', '6', null, 'name', '', '0', '1', '333', '4', '296', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'department', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8318', '招聘职位', 'position', null, '0', '0', '6', null, 'name', '', '0', '1', '333', '4', '297', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'position', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8319', '人数', 'requireNum', null, '0', '1', '2', null, '', '', '0', '1', '333', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'require_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8320', '目前进度说明', 'progressDesc', null, '0', '1', '1', null, '', '', '0', '1', '333', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'progress_desc', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8321', '已确定人数', 'finishNum', null, '0', '1', '2', null, '', '', '0', '1', '333', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'finish_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8322', '确定人员姓名', 'finishName', null, '0', '1', '1', null, '', '', '0', '0', '333', '0', null, null, '1', '1', '', null, '10', '50', '0', '0', '0', '0', 'finish_name', null, '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8323', '状态', 'status', null, '0', '1', '7', null, '', '', '0', '1', '333', '0', '334', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8361', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '354', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8362', '排序号', 'orderNum', null, '0', '0', '2', null, '', '', '0', '1', '354', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8363', '状态', 'status', null, '0', '0', '7', null, '', '', '0', '1', '354', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8364', '名称', 'name', null, '50', '0', '1', null, '', '', '0', '1', '355', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8365', '排序号', 'orderNum', null, '0', '0', '2', null, '', '', '0', '1', '355', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'order_num', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8366', '状态', 'status', null, '0', '0', '7', null, '', '', '0', '1', '355', '0', '311', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8367', '发文编号', 'number', null, '100', '0', '1', null, '', '', '0', '1', '356', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'number', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8368', '发文日期', 'recordDate', null, '0', '0', '4', null, '', 'yyyy-MM-dd', '0', '1', '356', '0', null, null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'record_date', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8369', '标题', 'title', null, '255', '0', '1', '', '', '', '0', '1', '356', '0', null, '0', '1', '0', '', null, '', '', '0', '0', '1', '0', 'title', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8370', '内容', 'content', null, '255', '0', '1', '', '', '', '0', '0', '356', '0', null, '0', '1', '1', '', null, '8', '100', '0', '0', '0', '0', 'content', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8371', '类型', 'type', null, '0', '0', '7', null, '', '', '0', '1', '356', '0', '358', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'type', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8372', '员工', 'employee', null, '0', '0', '6', null, 'name', '', '0', '1', '357', '4', '292', null, '0', '0', '', null, '', '', '0', '0', '1', '0', 'emp_no', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8373', '去年法定天数', 'lastLawDays', null, '0', '0', '2', null, '', '', '0', '1', '357', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'last_law_days', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8374', '去年司龄天数', 'lastJionAgeDays', null, '0', '0', '2', null, '', '', '0', '1', '357', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'last_jion_age_days', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8375', '去年已休天数', 'lastEnjoinedDays', null, '0', '0', '2', null, '', '', '0', '1', '357', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'last_enjoined_days', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8376', '法定天数', 'lawDays', null, '0', '0', '2', null, '', '', '0', '1', '357', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'law_days', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8377', '司龄天数', 'jionAgeDays', null, '0', '0', '2', null, '', '', '0', '1', '357', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'jion_age_days', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8378', '已休天数', 'enjoinedDays', null, '0', '0', '2', null, '', '', '0', '1', '357', '0', null, null, '0', '0', '', null, '', '', '0', '0', '0', '0', 'enjoined_days', null, '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8379', '休假明细', 'details', null, '255', '1', '1', '', '', '', '0', '0', '357', '0', null, '0', '1', '1', '', null, '8', '100', '0', '0', '0', '0', 'details', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8380', '创建时间', 'addTime', null, '0', '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '357', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '0', '0', 'add_time', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8381', '修改时间', 'updateTime', null, '0', '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '0', '1', '357', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '0', '0', 'update_time', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8382', '名称', 'name', null, '255', '0', '1', '', '', '', '1', '1', '359', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'name', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8383', '年龄', 'age', null, null, '1', '2', '', '', '', '2', '1', '359', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'age', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8384', '编号', 'id', null, null, '0', '2', '', '', '', '1', '0', '360', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'customer_id', '', '1', null, '', null);
INSERT INTO `t_property` VALUES ('8385', '姓名', 'name', null, '255', '1', '1', '', '', '', '2', '1', '360', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', '', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8386', '登录名', 'loginName', null, '255', '1', '1', '', '', '', '3', '1', '360', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'login_name', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8387', '编号', 'customerNo', null, '255', '1', '1', '', '', '', '4', '1', '360', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'customer_no', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8388', '部门', 'dept', null, '255', '1', '1', '', '', '', '5', '1', '360', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', '', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8389', '邮箱', 'mail', null, '255', '1', '1', '', '', '', '7', '1', '360', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'mail', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8390', '删除标记', 'isDelete', null, '255', '0', '2', '', '', '', '8', '1', '360', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'is_delete', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8391', '权限临时码', 'ssoKey', null, '255', '0', '1', '', '', '', '1', '1', '361', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'sso_key', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8392', '登录客户', 'customer', null, null, '0', '6', '', 'name', '', '2', '0', '361', '4', '360', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'customer_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8393', '平台标识符', 'terminal', null, '255', '0', '1', '', '', '', '3', '1', '361', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'terminal', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8394', '提问客户', 'customer', null, null, '0', '6', '', 'name', '', '1', '1', '362', '4', '360', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'customer_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8395', '问题', 'question', null, '255', '0', '1', '', '', '', '2', '1', '362', '0', null, '0', '1', '1', '', null, '5', '50', '0', '0', '1', '0', 'question', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8396', '答案', 'answer', null, '255', '0', '1', '', '', '', '3', '1', '362', '0', null, '0', '1', '1', '', null, '5', '50', '0', '0', '1', '0', 'answer', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8397', '记录时间', 'recordTime', null, null, '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '4', '1', '362', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'record_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8398', '会话ID', 'sessionId', null, '255', '0', '1', '', '', '', '1', '1', '365', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'session_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8399', '开始时间', 'startTime', null, null, '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '2', '1', '365', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'start_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8400', '结束时间', 'endTime', null, null, '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '3', '1', '365', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'end_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8401', '客户', 'customerId', null, null, '0', '6', '', 'name', '', '1', '1', '363', '4', '360', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'customer_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8402', '用户', 'user', null, null, '0', '6', '', 'userName', '', '2', '0', '363', '4', '366', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'user_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8403', '信息内容', 'content', null, '255', '0', '1', '', '', '', '3', '1', '363', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'content', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8404', '发送时间', 'sendTime', null, null, '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '4', '1', '363', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'send_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8405', '接收时间', 'receiveTime', null, null, '1', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '5', '1', '363', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'receive_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8406', '所属会话', 'session', null, null, '0', '6', '', 'id', '', '6', '0', '363', '4', '365', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'session_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8407', '客户', 'customer', null, null, '0', '6', '', 'name', '', '1', '1', '364', '4', '363', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'customerId', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8408', '用户', 'user', null, null, '0', '6', '', 'userName', '', '2', '1', '364', '4', '366', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'user_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8409', '信息内容', 'content', null, '255', '0', '1', '', '', '', '3', '1', '364', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'content', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8410', '发送时间', 'sendTime', null, null, '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '4', '1', '364', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'send_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8411', '接收时间', 'receiveTime', null, null, '0', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '5', '1', '364', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'receive_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8412', '所属会话', 'session', null, null, '0', '6', '', 'sessionId', '', '6', '1', '364', '4', '365', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'session_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8413', '客户', 'customer', null, null, '1', '6', '', 'name', '', '1', '1', '367', '4', '360', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'customer_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8414', '反馈时间', 'addTime', null, null, '1', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '2', '1', '367', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '1', 'add_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8415', '状态', 'status', null, null, '1', '2', '', '', '', '3', '1', '367', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'status', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8416', '处理时间', 'processTime', null, null, '1', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '4', '0', '367', '0', null, '0', '0', '0', '', null, '', '', '0', '0', '0', '0', 'process_time', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8417', '处理人', 'processor', null, null, '1', '6', '', 'userName', '', '1', '1', '367', '4', '366', '0', '0', '0', '', null, '', '', '0', '0', '1', '0', 'processor_id', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8418', '处理内容', 'processContent', null, '255', '1', '1', '', '', '', '6', '1', '367', '0', null, '0', '1', '1', '', null, '5', '60', '0', '0', '1', '0', 'process_content', '', '0', null, '', null);
INSERT INTO `t_property` VALUES ('8579', '姓名', 'name', null, '255', '1', '1', '', '', 'yyyy-MM-dd HH:mm:ss', '1', '0', '503', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'name', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8580', '姓名', 'name', null, '255', '1', '1', '', '', 'yyyy-MM-dd HH:mm:ss', '1', '1', '504', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'name', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8581', '创建时间', 'createTime', null, '255', '1', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '1', '1', '505', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'create_time', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8582', '内容', 'content', null, '255', '1', '1', '', '', 'yyyy-MM-dd HH:mm:ss', '2', '1', '505', '0', null, '0', '1', '1', '', null, '5', '60', '0', '0', '1', '0', 'content', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8583', '已搜索', 'isSearched', null, '255', '1', '2', '', '', 'yyyy-MM-dd HH:mm:ss', '3', '1', '505', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'is_searched', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8584', '已完成', 'isFinished', null, '255', '1', '2', '', '', 'yyyy-MM-dd HH:mm:ss', '4', '1', '505', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'is_finished', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8585', '搜索结果', 'searchResults', null, '255', '1', '6', '', '', 'yyyy-MM-dd HH:mm:ss', '5', '1', '505', '3', '506', '0', '0', '0', 'wordId', null, '5', '60', '0', '1', '1', '0', '', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8586', '百度URL', 'baiduUrl', null, '255', '1', '1', '', '', 'yyyy-MM-dd HH:mm:ss', '1', '1', '506', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'baidu_url', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8587', '实际URL', 'realUrl', null, '255', '1', '1', '', '', 'yyyy-MM-dd HH:mm:ss', '2', '1', '506', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'real_url', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8588', '内容', 'content', null, '255', '1', '1', '', '', 'yyyy-MM-dd HH:mm:ss', '3', '1', '506', '0', null, '0', '0', '1', '', null, '5', '60', '0', '0', '1', '0', 'content', '', '0', null, '', '1');
INSERT INTO `t_property` VALUES ('8589', '创建时间', 'createTime', null, '255', '1', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '4', '1', '506', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'create_time', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8590', '处理时间', 'processTime', null, '255', '1', '4', '', '', 'yyyy-MM-dd HH:mm:ss', '5', '1', '506', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'process_time', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8591', '处理结果', 'processResult', null, '255', '1', '2', '', '', 'yyyy-MM-dd HH:mm:ss', '6', '1', '506', '0', null, '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'process_result', '', '0', null, '', '0');
INSERT INTO `t_property` VALUES ('8592', '所属关键词', 'word', null, '255', '1', '6', '', 'content', 'yyyy-MM-dd HH:mm:ss', '7', '1', '506', '4', '505', '0', '0', '0', '', null, '5', '60', '0', '0', '1', '0', 'wordId', '', '0', null, '', '0');

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '管理员');

-- ----------------------------
-- Table structure for `t_role_modulars`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_modulars`;
CREATE TABLE `t_role_modulars` (
  `roleId` int(11) NOT NULL,
  `deskModular_Id` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`deskModular_Id`),
  KEY `FK27EF87C71D9BC788` (`deskModular_Id`) USING BTREE,
  KEY `FK27EF87C76D4D60B9` (`roleId`) USING BTREE,
  CONSTRAINT `t_role_modulars_ibfk_1` FOREIGN KEY (`deskModular_Id`) REFERENCES `t_deskmodular` (`id`),
  CONSTRAINT `t_role_modulars_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_modulars
-- ----------------------------

-- ----------------------------
-- Table structure for `t_role_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permissions`;
CREATE TABLE `t_role_permissions` (
  `roleId` int(11) NOT NULL,
  `permission_Id` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`permission_Id`),
  KEY `FKEBFDAAA67E01E36B` (`permission_Id`) USING BTREE,
  KEY `FKEBFDAAA639BCE158` (`roleId`) USING BTREE,
  CONSTRAINT `t_role_permissions_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`),
  CONSTRAINT `t_role_permissions_ibfk_2` FOREIGN KEY (`permission_Id`) REFERENCES `t_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 16384 kB; (`roleId`) REFER `crm_zsy/t_role`(`id';

-- ----------------------------
-- Records of t_role_permissions
-- ----------------------------
INSERT INTO `t_role_permissions` VALUES ('1', '864');
INSERT INTO `t_role_permissions` VALUES ('1', '865');
INSERT INTO `t_role_permissions` VALUES ('1', '866');
INSERT INTO `t_role_permissions` VALUES ('1', '867');
INSERT INTO `t_role_permissions` VALUES ('1', '872');
INSERT INTO `t_role_permissions` VALUES ('1', '873');
INSERT INTO `t_role_permissions` VALUES ('1', '874');
INSERT INTO `t_role_permissions` VALUES ('1', '875');
INSERT INTO `t_role_permissions` VALUES ('1', '876');
INSERT INTO `t_role_permissions` VALUES ('1', '877');
INSERT INTO `t_role_permissions` VALUES ('1', '878');
INSERT INTO `t_role_permissions` VALUES ('1', '879');
INSERT INTO `t_role_permissions` VALUES ('1', '893');
INSERT INTO `t_role_permissions` VALUES ('1', '927');
INSERT INTO `t_role_permissions` VALUES ('1', '928');
INSERT INTO `t_role_permissions` VALUES ('1', '929');
INSERT INTO `t_role_permissions` VALUES ('1', '930');
INSERT INTO `t_role_permissions` VALUES ('1', '931');
INSERT INTO `t_role_permissions` VALUES ('1', '940');
INSERT INTO `t_role_permissions` VALUES ('1', '1231');
INSERT INTO `t_role_permissions` VALUES ('1', '1232');
INSERT INTO `t_role_permissions` VALUES ('1', '1233');
INSERT INTO `t_role_permissions` VALUES ('1', '1234');
INSERT INTO `t_role_permissions` VALUES ('1', '1235');
INSERT INTO `t_role_permissions` VALUES ('1', '1236');
INSERT INTO `t_role_permissions` VALUES ('1', '1237');
INSERT INTO `t_role_permissions` VALUES ('1', '1239');
INSERT INTO `t_role_permissions` VALUES ('1', '1393');
INSERT INTO `t_role_permissions` VALUES ('1', '1394');
INSERT INTO `t_role_permissions` VALUES ('1', '1406');
INSERT INTO `t_role_permissions` VALUES ('1', '1407');
INSERT INTO `t_role_permissions` VALUES ('1', '1408');
INSERT INTO `t_role_permissions` VALUES ('1', '1409');
INSERT INTO `t_role_permissions` VALUES ('1', '1410');
INSERT INTO `t_role_permissions` VALUES ('1', '1411');
INSERT INTO `t_role_permissions` VALUES ('1', '1562');
INSERT INTO `t_role_permissions` VALUES ('1', '1609');
INSERT INTO `t_role_permissions` VALUES ('1', '1610');
INSERT INTO `t_role_permissions` VALUES ('1', '1611');
INSERT INTO `t_role_permissions` VALUES ('1', '1612');
INSERT INTO `t_role_permissions` VALUES ('1', '1613');
INSERT INTO `t_role_permissions` VALUES ('1', '1614');
INSERT INTO `t_role_permissions` VALUES ('1', '1615');
INSERT INTO `t_role_permissions` VALUES ('1', '1616');
INSERT INTO `t_role_permissions` VALUES ('1', '1617');
INSERT INTO `t_role_permissions` VALUES ('1', '1618');
INSERT INTO `t_role_permissions` VALUES ('1', '1619');
INSERT INTO `t_role_permissions` VALUES ('1', '1620');
INSERT INTO `t_role_permissions` VALUES ('1', '1621');
INSERT INTO `t_role_permissions` VALUES ('1', '1622');
INSERT INTO `t_role_permissions` VALUES ('1', '1632');
INSERT INTO `t_role_permissions` VALUES ('1', '1633');
INSERT INTO `t_role_permissions` VALUES ('1', '1634');
INSERT INTO `t_role_permissions` VALUES ('1', '1635');
INSERT INTO `t_role_permissions` VALUES ('1', '1636');
INSERT INTO `t_role_permissions` VALUES ('1', '1637');
INSERT INTO `t_role_permissions` VALUES ('1', '1638');
INSERT INTO `t_role_permissions` VALUES ('1', '1639');
INSERT INTO `t_role_permissions` VALUES ('1', '1640');
INSERT INTO `t_role_permissions` VALUES ('1', '1641');
INSERT INTO `t_role_permissions` VALUES ('1', '1642');
INSERT INTO `t_role_permissions` VALUES ('1', '1643');
INSERT INTO `t_role_permissions` VALUES ('1', '1644');
INSERT INTO `t_role_permissions` VALUES ('1', '1645');
INSERT INTO `t_role_permissions` VALUES ('1', '1646');
INSERT INTO `t_role_permissions` VALUES ('1', '1647');
INSERT INTO `t_role_permissions` VALUES ('1', '1676');
INSERT INTO `t_role_permissions` VALUES ('1', '1677');
INSERT INTO `t_role_permissions` VALUES ('1', '1678');
INSERT INTO `t_role_permissions` VALUES ('1', '1679');
INSERT INTO `t_role_permissions` VALUES ('1', '1680');
INSERT INTO `t_role_permissions` VALUES ('1', '1681');
INSERT INTO `t_role_permissions` VALUES ('1', '1682');
INSERT INTO `t_role_permissions` VALUES ('1', '1683');
INSERT INTO `t_role_permissions` VALUES ('1', '1684');
INSERT INTO `t_role_permissions` VALUES ('1', '1685');
INSERT INTO `t_role_permissions` VALUES ('1', '1686');
INSERT INTO `t_role_permissions` VALUES ('1', '1687');
INSERT INTO `t_role_permissions` VALUES ('1', '1688');
INSERT INTO `t_role_permissions` VALUES ('1', '1689');
INSERT INTO `t_role_permissions` VALUES ('1', '1690');
INSERT INTO `t_role_permissions` VALUES ('1', '1691');
INSERT INTO `t_role_permissions` VALUES ('1', '1692');
INSERT INTO `t_role_permissions` VALUES ('1', '1693');
INSERT INTO `t_role_permissions` VALUES ('1', '1694');
INSERT INTO `t_role_permissions` VALUES ('1', '1695');
INSERT INTO `t_role_permissions` VALUES ('1', '1696');
INSERT INTO `t_role_permissions` VALUES ('1', '1697');
INSERT INTO `t_role_permissions` VALUES ('1', '1698');
INSERT INTO `t_role_permissions` VALUES ('1', '1699');
INSERT INTO `t_role_permissions` VALUES ('1', '1700');
INSERT INTO `t_role_permissions` VALUES ('1', '1701');
INSERT INTO `t_role_permissions` VALUES ('1', '1702');
INSERT INTO `t_role_permissions` VALUES ('1', '1703');
INSERT INTO `t_role_permissions` VALUES ('1', '1704');
INSERT INTO `t_role_permissions` VALUES ('1', '1705');
INSERT INTO `t_role_permissions` VALUES ('1', '1706');
INSERT INTO `t_role_permissions` VALUES ('1', '1707');
INSERT INTO `t_role_permissions` VALUES ('1', '1708');
INSERT INTO `t_role_permissions` VALUES ('1', '1709');
INSERT INTO `t_role_permissions` VALUES ('1', '1710');
INSERT INTO `t_role_permissions` VALUES ('1', '1711');
INSERT INTO `t_role_permissions` VALUES ('1', '1712');
INSERT INTO `t_role_permissions` VALUES ('1', '1713');

-- ----------------------------
-- Table structure for `t_rule`
-- ----------------------------
DROP TABLE IF EXISTS `t_rule`;
CREATE TABLE `t_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `templateId` int(11) DEFAULT NULL,
  `outputDir` varchar(255) DEFAULT NULL,
  `outputFileName` varchar(255) DEFAULT NULL,
  `cause` varchar(255) DEFAULT NULL,
  `append` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCB6277E7167CA3C6` (`templateId`) USING BTREE,
  CONSTRAINT `t_rule_ibfk_1` FOREIGN KEY (`templateId`) REFERENCES `t_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_rule
-- ----------------------------
INSERT INTO `t_rule` VALUES ('3', '1', '/WebRoot/WEB-INF/pages/${entity.lowerClassName}', 'add.jsp', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('4', '5', '/WebRoot/WEB-INF/pages/${entity.lowerClassName}', 'update.jsp', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('5', '6', 'WebRoot/WEB-INF/pages/${entity.lowerClassName}', 'list.jsp', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('6', '7', 'src.${entity.packagee.fullPackageName}../controller/', '${entity.className}Controller.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('7', '8', 'src.${entity.packagee.fullPackageName}../service/', 'I${entity.className}Service.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('8', '9', 'src.${entity.packagee.fullPackageName}../service/impl', '${entity.className}ServiceImpl.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('9', '10', 'src.${entity.packagee.fullPackageName}../dao', 'I${entity.className}Dao.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('10', '11', 'src.${entity.packagee.fullPackageName}../dao/impl', '${entity.className}DaoImpl.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('11', '13', 'src.${entity.packagee.fullPackageName}', '${entity.className}.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('12', '14', 'src.${entity.packagee.fullPackageName}', '${entity.className}.java', '${entity.type}=1', '');
INSERT INTO `t_rule` VALUES ('13', '15', 'src.${entity.packagee.fullPackageName}.propertyeditor', '${entity.className}Editor.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('14', '16', '/', 'menu_sql.sql', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('15', '17', '/WebRoot/WEB-INF/pages/${entity.lowerClassName}', 'add.jsp', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('16', '18', '/WebRoot/WEB-INF/pages/${entity.lowerClassName}', 'update.jsp', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('17', '19', 'WebRoot/WEB-INF/pages/${entity.lowerClassName}', 'list.jsp', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('18', '20', 'src.${entity.packagee.fullPackageName}../controller/', '${entity.className}Controller.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('19', '21', 'src.${entity.packagee.fullPackageName}../service/', 'I${entity.className}Service.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('20', '22', 'src.${entity.packagee.fullPackageName}../service/impl', '${entity.className}ServiceImpl.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('21', '23', 'src.${entity.packagee.fullPackageName}../dao', 'I${entity.className}Dao.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('22', '24', 'src.${entity.packagee.fullPackageName}../dao/impl', '${entity.className}DaoImpl.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('23', '25', 'src.${entity.packagee.fullPackageName}', '${entity.className}.java', '${entity.type}=0', '');
INSERT INTO `t_rule` VALUES ('24', '26', 'src.${entity.packagee.fullPackageName}', '${entity.className}.java', '${entity.type}=1', '');
INSERT INTO `t_rule` VALUES ('25', '27', 'src.${entity.packagee.fullPackageName}.propertyeditor', '${entity.className}Editor.java', '${entity.type}=0', '');

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `teacherId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4B9075702F2A794F` (`teacherId`) USING BTREE,
  CONSTRAINT `t_student_ibfk_1` FOREIGN KEY (`teacherId`) REFERENCES `t_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('1', '张三', '3');

-- ----------------------------
-- Table structure for `t_systemconfig`
-- ----------------------------
DROP TABLE IF EXISTS `t_systemconfig`;
CREATE TABLE `t_systemconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phoneDisplayType` int(11) DEFAULT NULL,
  `ocxObjSource` longtext,
  `phoneServerIp` varchar(255) DEFAULT NULL,
  `versionDesc` varchar(255) DEFAULT NULL,
  `objId` varchar(255) DEFAULT NULL,
  `recorderUrl` varchar(255) DEFAULT NULL,
  `systemTitle` varchar(255) DEFAULT NULL,
  `loginImage` varchar(255) DEFAULT NULL,
  `mainBgImage` varchar(255) DEFAULT NULL,
  `subTitle` varchar(255) DEFAULT NULL,
  `useCheckCode` int(11) DEFAULT NULL,
  `notifyTime` int(11) DEFAULT NULL,
  `selfPlayer` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_systemconfig
-- ----------------------------
INSERT INTO `t_systemconfig` VALUES ('1', '1', '<OBJECT ID=\'zdphone\' width=\'1050\' height=\'30\' CLASSID=\'CLSID:F0E9CC0B-A281-41A0-BCCD-E12E4039063A\'></OBJECT>', '192.168.0.200', 'version0.1', 'zdphone', 'http://192.168.0.200:8080/recorder/recordfile/', 'CodeMaker for BPM V2.0', null, null, 'CodeMaker for BPM V2.0', '0', '14', '1');

-- ----------------------------
-- Table structure for `t_tasknode`
-- ----------------------------
DROP TABLE IF EXISTS `t_tasknode`;
CREATE TABLE `t_tasknode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `listurl` varchar(255) DEFAULT NULL,
  `processurl` varchar(255) DEFAULT NULL,
  `submiturl` varchar(255) DEFAULT NULL,
  `contextEntityId` int(11) DEFAULT NULL,
  `filterCause` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9E460C72367254C7` (`contextEntityId`),
  CONSTRAINT `FK9E460C72367254C7` FOREIGN KEY (`contextEntityId`) REFERENCES `t_entity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_tasknode
-- ----------------------------
INSERT INTO `t_tasknode` VALUES ('10', '人员处理', 'processList', 'processUI', 'process', '292', '');

-- ----------------------------
-- Table structure for `t_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sexId` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65C3BF17A9BF51BA` (`sexId`) USING BTREE,
  CONSTRAINT `t_teacher_ibfk_1` FOREIGN KEY (`sexId`) REFERENCES `t_dictionarydetail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES ('3', 'dsfdfdfdf', '32', '2', 'fdsfs');
INSERT INTO `t_teacher` VALUES ('4', 'xxxfdsfds', '1', '2', 'sdfsdfdsf');

-- ----------------------------
-- Table structure for `t_template`
-- ----------------------------
DROP TABLE IF EXISTS `t_template`;
CREATE TABLE `t_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `content` text,
  `groupId` int(11) DEFAULT NULL,
  `_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK67E73FE57CC22C28` (`groupId`) USING BTREE,
  CONSTRAINT `t_template_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `t_templategroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_template
-- ----------------------------
INSERT INTO `t_template` VALUES ('1', '添加页面', '[_LT]%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%[_GT]\r\n[_LT]%@include file=\"/WEB-INF/jsp/common/taglib.jsp\"%[_GT]\r\n[_LT]div class=\"pageContent\"[_GT]\r\n	[_LT]form:form method=\"post\" action=\"${entity.lowerClassName}/add.do\" class=\"pageForm required-validate\" commandName=\"${entity.lowerClassName}\" onsubmit=\"return validateCallback(this, navTabAjaxDone);\"[_GT]\r\n		[_LT]input type=\"hidden\" value=\"[_D]{rel}\" name=\"rel\"/[_GT]\r\n		[_LT]div class=\"formBar\"[_GT]\r\n			[_LT]ul[_GT]\r\n				[_LT]!--[_LT]li[_GT][_LT]a class=\"buttonActive\" href=\"javascript:;\"[_GT][_LT]span[_GT]保存[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]--[_GT]\r\n				[_LT]li[_GT][_LT]div class=\"buttonActive\"[_GT][_LT]div class=\"buttonContent\"[_GT][_LT]button type=\"submit\"[_GT]保存[_LT]/button[_GT][_LT]/div[_GT][_LT]/div[_GT][_LT]/li[_GT]\r\n				[_LT]li[_GT]\r\n					[_LT]div class=\"button\"[_GT][_LT]div class=\"buttonContent\"[_GT][_LT]button type=\"button\" class=\"close\"[_GT]取消[_LT]/button[_GT][_LT]/div[_GT][_LT]/div[_GT]\r\n				[_LT]/li[_GT]\r\n			[_LT]/ul[_GT]\r\n		[_LT]/div[_GT]\r\n		[_LT]div class=\"pageFormContent\" layoutH=\"56\"[_GT]\r\n			#{ADD_INPUT_TRS}\r\n		[_LT]/div[_GT]\r\n	[_LT]/form:form[_GT]\r\n[_LT]/div[_GT]', '1', '1');
INSERT INTO `t_template` VALUES ('5', '修改页面', '[_LT]%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%[_GT]\r\n[_LT]%@include file=\"/WEB-INF/jsp/common/taglib.jsp\"%[_GT]\r\n[_LT]div class=\"pageContent\"[_GT]\r\n	[_LT]form:form method=\"post\" action=\"${entity.lowerClassName}/update.do\" class=\"pageForm required-validate\" commandName=\"${entity.lowerClassName}\" onsubmit=\"return validateCallback(this, navTabAjaxDone);\"[_GT]\r\n		[_LT]input type=\"hidden\" value=\"[_D]{rel}\" name=\"rel\"/[_GT]\r\n		[_LT]form:input type=\"hidden\" path=\"${empty entity.idColumnProp ? \'id\' : entity.idColumnProp.propName}\"/[_GT]\r\n		[_LT]div class=\"formBar\"[_GT]\r\n			[_LT]ul[_GT]\r\n				[_LT]!--[_LT]li[_GT][_LT]a class=\"buttonActive\" href=\"javascript:;\"[_GT][_LT]span[_GT]保存[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]--[_GT]\r\n				[_LT]li[_GT][_LT]div class=\"buttonActive\"[_GT][_LT]div class=\"buttonContent\"[_GT][_LT]button type=\"submit\"[_GT]保存[_LT]/button[_GT][_LT]/div[_GT][_LT]/div[_GT][_LT]/li[_GT]\r\n				[_LT]li[_GT]\r\n					[_LT]div class=\"button\"[_GT][_LT]div class=\"buttonContent\"[_GT][_LT]button type=\"button\" class=\"close\"[_GT]取消[_LT]/button[_GT][_LT]/div[_GT][_LT]/div[_GT]\r\n				[_LT]/li[_GT]\r\n			[_LT]/ul[_GT]\r\n		[_LT]/div[_GT]\r\n		[_LT]div class=\"pageFormContent\" layoutH=\"56\"[_GT]\r\n			#{UPDATE_INPUT_TRS}\r\n		[_LT]/div[_GT]\r\n	[_LT]/form:form[_GT]\r\n[_LT]/div[_GT]', '1', '1');
INSERT INTO `t_template` VALUES ('6', '列表页面', '[_LT]%@page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%[_GT]\r\n[_LT]%@include file=\"/WEB-INF/jsp/common/taglib.jsp\"%[_GT]\r\n[_LT]form:form onsubmit=\"return navTabSearch(this);\" action=\"${entity.lowerClassName}/list.do\" method=\"post\" commandName=\"${entity.lowerClassName}\" id=\"pagerForm\"[_GT]\r\n[_LT]input type=\"hidden\" name=\"pageNum\" value=\"[_D]{pageBean.pageNum}\" /[_GT]\r\n[_LT]input type=\"hidden\" name=\"orderField\" value=\"[_D]{pageBean.orderField}\" /[_GT]\r\n[_LT]input type=\"hidden\" name=\"orderDirection\" value=\"[_D]{pageBean.orderDirection}\" /[_GT]\r\n[_LT]div class=\"pageHeader\"[_GT]\r\n	[_LT]div class=\"searchBar\"[_GT]\r\n		[_LT]ul class=\"searchContent\"[_GT]\r\n			#{QUERY_TABLE}\r\n		[_LT]/ul[_GT]\r\n		[_LT]div class=\"subBar\"[_GT]\r\n			[_LT]ul[_GT]\r\n				[_LT]li[_GT][_LT]div class=\"buttonActive\"[_GT][_LT]div class=\"buttonContent\"[_GT][_LT]button type=\"submit\"[_GT]检索[_LT]/button[_GT][_LT]/div[_GT][_LT]/div[_GT][_LT]/li[_GT]\r\n			[_LT]/ul[_GT]\r\n		[_LT]/div[_GT]\r\n	[_LT]/div[_GT]\r\n[_LT]/div[_GT]\r\n[_LT]div class=\"pageContent\"[_GT]\r\n	[_LT]div class=\"panelBar\"[_GT]\r\n		[_LT]ul class=\"toolBar\"[_GT]\r\n			[_LT]li[_GT][_LT]a class=\"add\" href=\"${entity.lowerClassName}/add.do?rel=nav_tab\" target=\"navTab\" rel=\"[_D]{rel}_add\"[_GT][_LT]span[_GT]添加[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]\r\n			[_LT]li[_GT][_LT]a class=\"edit\" href=\"${entity.lowerClassName}/update.do?${entity.idColumnName}={sid_${entity.lowerClassName}}&rel=nav_tab\" target=\"navTab\" rel=\"[_D]{rel}_update\"[_GT][_LT]span[_GT]修改[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]\r\n			[_LT]li[_GT][_LT]a class=\"edit\" href=\"${entity.lowerClassName}/detail.do?${entity.idColumnName}={sid_${entity.lowerClassName}}&rel=nav_tab\" target=\"navTab\" rel=\"[_D]{rel}_detail\"[_GT][_LT]span[_GT]查看[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]\r\n			[_LT]li[_GT][_LT]a class=\"delete\" href=\"${entity.lowerClassName}/delete.do?${entity.idColumnName}={sid_${entity.lowerClassName}}&rel=nav_tab\" target=\"ajaxTodo\" title=\"确定要删除吗?\" method=\"GET\"[_GT][_LT]span[_GT]删除[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]\r\n			[_LT]%--\r\n			[_LT]li class=\"line\"[_GT]line[_LT]/li[_GT]\r\n			[_LT]li[_GT][_LT]a title=\"确实要删除这些记录吗?\" target=\"selectedTodo\" postType=\"string\" href=\"${entity.lowerClassName}/delete.do\" class=\"delete\" method=\"POST\"[_GT][_LT]span[_GT]批量删除[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]\r\n			[_LT]li class=\"line\"[_GT]line[_LT]/li[_GT]\r\n			[_LT]li[_GT][_LT]a class=\"icon\" href=\"demo/common/dwz-team.xls\" target=\"dwzExport\" targetType=\"navTab\" title=\"实要导出这些记录吗?\"[_GT][_LT]span[_GT]导出EXCEL[_LT]/span[_GT][_LT]/a[_GT][_LT]/li[_GT]\r\n			--%[_GT]\r\n		[_LT]/ul[_GT]\r\n	[_LT]/div[_GT]\r\n	[_LT]table class=\"table\" width=\"100%\" layoutH=\"138\"[_GT]\r\n		[_LT]thead[_GT]\r\n			[_LT]tr[_GT]\r\n				#{HEAD_TDS}\r\n			[_LT]/tr[_GT]\r\n		[_LT]/thead[_GT]\r\n		[_LT]tbody[_GT]\r\n			[_LT]c:if test=\"[_D]{empty pageBean.list}\"[_GT]\r\n				[_LT]tr[_GT]\r\n					[_LT]td colspan=\"${fn:length(entity.properties)+2}\"[_GT]\r\n						[_LT]center[_GT]\r\n							[_LT]font style=\"color: gray;\"[_GT]暂无记录 [_LT]/font[_GT]\r\n						[_LT]/center[_GT]\r\n					[_LT]/td[_GT]\r\n				[_LT]/tr[_GT]\r\n			[_LT]/c:if[_GT]\r\n			[_LT]c:forEach var=\"temp${entity.lowerClassName}\" items =\"[_D]{pageBean.list}\" varStatus=\"stauts\"[_GT]\r\n				[_LT]tr target=\"sid_${entity.lowerClassName}\" rel=\"[_D]{temp${entity.lowerClassName}.${entity.idColumnName}}\"[_GT]\r\n				#{BODY_TDS}\r\n				[_LT]/tr[_GT]\r\n			[_LT]/c:forEach[_GT]\r\n		[_LT]/tbody[_GT]\r\n	[_LT]/table[_GT]\r\n	[_LT]%@include file=\"/WEB-INF/jsp/common/pageBar.jsp\" %[_GT]\r\n[_LT]/div[_GT]\r\n[_LT]/form:form[_GT]', '1', '1');
INSERT INTO `t_template` VALUES ('7', 'Controller层代码', 'package ${entity.currentFileFullPackage};\r\n\r\nimport java.util.Date;\r\nimport java.util.List;\r\n\r\nimport javax.annotation.Resource;\r\nimport javax.servlet.http.HttpServletRequest;\r\nimport javax.servlet.http.HttpSession;\r\nimport javax.validation.Valid;\r\n\r\nimport org.springframework.beans.factory.annotation.Autowired;\r\nimport org.springframework.stereotype.Controller;\r\nimport org.springframework.validation.BindingResult;\r\nimport org.springframework.validation.Errors;\r\nimport org.springframework.validation.FieldError;\r\nimport org.springframework.validation.Validator;\r\nimport org.springframework.web.bind.WebDataBinder;\r\nimport org.springframework.web.bind.annotation.InitBinder;\r\nimport org.springframework.web.bind.annotation.ModelAttribute;\r\nimport org.springframework.web.bind.annotation.PathVariable;\r\nimport org.springframework.web.bind.annotation.RequestMapping;\r\nimport org.springframework.web.bind.annotation.RequestMethod;\r\nimport org.springframework.web.bind.annotation.RequestParam;\r\nimport org.springframework.web.bind.annotation.ResponseBody;\r\n\r\nimport com.lenovots.jdhr.common.entity.enumtype.YesNo;\r\nimport com.lenovots.jdhr.employee.entity.Employee;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.Degree;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.DimissReason;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.DimissType;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.Sex;\r\nimport com.lenovots.jdhr.hr.entity.HrResource;\r\nimport com.lenovots.jdhr.system.entity.FunctionPoint;\r\nimport com.lenovots.jdhr.system.entity.propertyeditor.FunctionPointEditor;\r\nimport com.lenovots.jdhr.util.web.JsonResult;\r\n\r\n/**\r\n * ${entity.name}Controller auto created by pc\r\n * @author pc\r\n * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\n@Controller\r\n@RequestMapping(\"/${entity.lowerClassName}\")\r\npublic class ${entity.className}Controller extends BaseController {\r\n\r\n    @Resource\r\n    private I${entity.className}Service ${entity.lowerClassName}Service;\r\n    \r\n    @InitBinder\r\n	public void initPropEditor(WebDataBinder binder){\r\n    	    //注册属性编辑器\r\n	    #{INIT_PROP_EDITOR}\r\n	}\r\n    \r\n    //复杂关联关系的Service\r\n    #{COMPLEX_SERVICES_DEFINE}\r\n    \r\n    @ModelAttribute\r\n    public ${entity.className} initModelAttribute(@RequestParam(value=\"${entity.idColumnName}\",required=false) ${empty entity.idColumnProp ? \'Integer\':entity.idColumnProp.dataTypeName} ${entity.idColumnName}){\r\n    	${entity.className} ${entity.lowerClassName} = null;\r\n    	if(${entity.idColumnName}==null || ${entity.idColumnName}.equals(\"\")){\r\n    		${entity.lowerClassName} = new ${entity.className}();\r\n    	}else{\r\n    		${entity.lowerClassName} = ${entity.lowerClassName}Service.getById(${entity.className}.class, ${entity.idColumnName});\r\n    	}\r\n    	return ${entity.lowerClassName};\r\n    }\r\n    \r\n    /**\r\n     * ${entity.name}列表\r\n     * @param request\r\n     * @return\r\n     * @author pc\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/list\")\r\n    public void list(HttpServletRequest request,${entity.className} ${entity.lowerClassName},Page pageInfo) {\r\n        Page<${entity.className}> ${entity.lowerClassName}Page = ${entity.lowerClassName}Service.getListPage(${entity.lowerClassName},pageInfo);\r\n        request.setAttribute(\"pageBean\", ${entity.lowerClassName}Page);\r\n        //复杂关联关系数据准备\r\n    	#{COMPLEX_LIST_PREPARE}\r\n    }\r\n    \r\n    /**\r\n     * 添加${entity.name}页面\r\n     * @param request\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/add\",method=RequestMethod.GET)\r\n    public void addUI(HttpServletRequest request) {\r\n    	//复杂关联关系数据准备\r\n        #{COMPLEX_LIST_PREPARE}\r\n    }\r\n    \r\n    /**\r\n     * 添加ENTITY_REALY_NAME\r\n     * @param ${entity.lowerClassName}\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/add\",method=RequestMethod.POST)\r\n    @ResponseBody\r\n    public JsonResult add(@RequestParam(\"rel\") String rel,@Valid @ModelAttribute(\"${entity.lowerClassName}\") ${entity.className} ${entity.lowerClassName},BindingResult result) {\r\n    	JsonResult jsonResult = new JsonResult();\r\n    	//if(!validate(jsonResult,result)){\r\n    	//	return jsonResult;\r\n    	//}\r\n    	//默认系统时间类型保存\r\n    	#{DATATYPE_DEFAULT_VALUE_SAVE}\r\n    	${entity.lowerClassName}Service.add(${entity.lowerClassName});\r\n    	jsonResult.setNavTabId(rel);\r\n    	jsonResult.setMessage(\"添加成功\");\r\n        return jsonResult;\r\n    }\r\n    \r\n    /**\r\n     * 修改ENTITY_REALY_NAME页面\r\n     * @param uid\r\n     * @param request\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/update\",method=RequestMethod.GET)\r\n	public void updateUI(@RequestParam(value=\"${empty entity.idColumnProp ? \'id\' : entity.idColumnProp.propName}\") ${empty entity.idColumnProp ? \'Integer\' : entity.idColumnProp.dataTypeName} ${empty entity.idColumnProp ? \'id\' : entity.idColumnProp.propName},HttpServletRequest request) {\r\n    	//复杂关联关系数据准备\r\n        #{COMPLEX_LIST_PREPARE}\r\n    }\r\n    \r\n    /**\r\n     * 修改${entity.name}\r\n     * @param ${entity.lowerClassName}\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/update\",method=RequestMethod.POST)\r\n    @ResponseBody\r\n    public JsonResult update(@RequestParam(\"rel\") String rel,@ModelAttribute ${entity.className} ${entity.lowerClassName},BindingResult result) {\r\n    	JsonResult jsonResult = new JsonResult();\r\n    	if(!validate(jsonResult,result)){\r\n    		return jsonResult;\r\n    	}\r\n	\r\n        ${entity.lowerClassName}Service.update(${entity.lowerClassName});\r\n	    jsonResult.setNavTabId(rel);\r\n        jsonResult.setMessage(\"修改成功\");\r\n        return jsonResult;\r\n    }\r\n    \r\n    /**\r\n     * 删除单个\r\n     * @param uid\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/delete\",method=RequestMethod.GET)\r\n    @ResponseBody\r\n    public JsonResult delete(@RequestParam(\"rel\") String rel,@ModelAttribute ${entity.className} ${entity.lowerClassName}) {\r\n        JsonResult jsonResult = new JsonResult();\r\n        jsonResult.setCallbackType(\"\");\r\n        try {\r\n        	${entity.lowerClassName}Service.delete(${entity.lowerClassName});\r\n		} catch (RuntimeException re) {\r\n			jsonResult.setMessage(\"该记录已被使用，不能删除！\");\r\n			return jsonResult;\r\n		}catch (Exception e) {\r\n			jsonResult.setMessage(e.toString());\r\n			return jsonResult;\r\n		}\r\n        jsonResult.setNavTabId(rel);\r\n        jsonResult.setMessage(\"删除成功\");\r\n        return jsonResult;\r\n    }\r\n    \r\n	@RequestMapping(value = \"/detail\", method = RequestMethod.GET)\r\n	public void detailUI(@ModelAttribute ${entity.className} ${entity.lowerClassName},HttpServletRequest request) {\r\n		#{COMPLEX_LIST_PREPARE}\r\n	}\r\n	\r\n    /**\r\n     * 删除多个\r\n     * @param uids\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n   \r\n    @RequestMapping(value=\"/delete\",method=RequestMethod.POST)\r\n    @ResponseBody\r\n    public JsonResult batchDelete(@RequestParam(\"ID_PROPERTY_NAMEs\") ID_PROPERTY_DATATYPENAME[] ID_PROPERTY_NAMEs) {\r\n    	${entity.className} ${entity.lowerClassName} = null;\r\n    	for(ID_PROPERTY_DATATYPENAME id : ID_PROPERTY_NAMEs){\r\n    		${entity.lowerClassName} = ${entity.lowerClassName}Service.loadById(${entity.className}.class, id);\r\n    		${entity.lowerClassName}Service.delete(${entity.lowerClassName});\r\n    	}\r\n    	JsonResult jsonResult = new JsonResult();\r\n    	jsonResult.setMessage(\"删除成功\");\r\n    	return jsonResult;\r\n    } \r\n    */\r\n    \r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('8', 'Service接口代码', 'package ${entity.currentFileFullPackage};\r\n\r\nimport com.lenovots.demo.func.service.PageInfo;\r\n\r\nimport ${entity.fullClassName};\r\n/**\r\n * ${entity.name}Service接口\r\n * @author \r\n *  <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\npublic interface I${entity.className}Service extends IBaseService<${entity.className}> {\r\n\r\n    /**\r\n     * 得到分页信息\r\n     * @param role\r\n     * @return\r\n     */\r\n    public Page<${entity.className}> getListPage(${entity.className} ${entity.lowerClassName},Page pageInfo);\r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('9', 'Service实现代码', 'package ${entity.currentFileFullPackage};\r\n\r\nimport java.util.List;\r\n\r\nimport javax.annotation.Resource;\r\nimport org.springframework.stereotype.Service;\r\n\r\nimport com.lenovots.jdhr.util.web.Page;\r\n\r\nimport ${entity.fullClassName};\r\n\r\n\r\n/**\r\n * ${entity.name}实现\r\n * @author \r\n * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\n@Service\r\npublic class ${entity.className}ServiceImpl extends BaseServiceImpl<${entity.className}> implements I${entity.className}Service {\r\n\r\n    @Resource\r\n    private I${entity.className}Dao ${entity.lowerClassName}Dao;\r\n    \r\n    @Override\r\n    public Page<${entity.className}> getListPage(${entity.className} ${entity.lowerClassName},Page pageInfo) {\r\n      	pageInfo.setTotalCount(${entity.lowerClassName}Dao.findListRowCount(${entity.lowerClassName}).intValue());\r\n		pageInfo.setOrderField(pageInfo.getOrderField() == null ? \"id\": pageInfo.getOrderField());\r\n		pageInfo.setOrderDirection(pageInfo.getOrderDirection() == null ? \"asc\": pageInfo.getOrderDirection());\r\n		pageInfo.setList(${entity.lowerClassName}Dao.findListPage(${entity.lowerClassName},pageInfo));\r\n        return pageInfo;\r\n    }\r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('10', 'Dao接口代码', 'package ${entity.currentFileFullPackage};\r\nimport java.util.List;\r\n\r\nimport com.lenovots.jdhr.employee.entity.EmployeeAttribute;\r\n\r\nimport ${entity.fullClassName};\r\n/**\r\n * ${entity.name}接口\r\n * @author auto created by pc\r\n * <fmt:formatDate value=\"${NOW}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\npublic interface I${entity.className}Dao extends IBaseDao<${entity.className}> {\r\n\r\n    /**\r\n     * 查询记录数\r\n     * @param role\r\n     * @return\r\n     */\r\n	Long findListRowCount(${entity.className} ${entity.lowerClassName});\r\n\r\n    /**\r\n     * 分页查询角色信息\r\n     * @param role\r\n     * @return\r\n     */\r\n    List<${entity.className}> findListPage(${entity.className} ${entity.lowerClassName}, Page pageInfo);\r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('11', 'Dao实现代码', 'package ${entity.currentFileFullPackage};\r\nimport java.util.List;\r\n\r\nimport org.hibernate.Criteria;\r\nimport org.hibernate.criterion.MatchMode;\r\nimport org.hibernate.criterion.Order;\r\nimport org.hibernate.criterion.Projections;\r\nimport org.hibernate.criterion.Restrictions;\r\nimport org.springframework.stereotype.Repository;\r\n\r\nimport ${entity.fullClassName};\r\n/**\r\n * ${entity.name}Dao实现\r\n * @author auto created by pc\r\n * <fmt:formatDate value=\"${NOW}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\n@Repository\r\npublic class ${entity.className}DaoImpl extends BaseDaoImpl<${entity.className}> implements I${entity.className}Dao {\r\n\r\n    @Override\r\n    public Long findListRowCount(${entity.className} ${entity.lowerClassName}) {\r\n        Criteria criteria = getSession().createCriteria(${entity.className}.class).setProjection(Projections.rowCount());\r\n        addQueryCause(criteria,${entity.lowerClassName});\r\n        return (Long) criteria.uniqueResult();\r\n    }\r\n\r\n    @SuppressWarnings(\"unchecked\")\r\n    @Override\r\n    public List<${entity.className}> findListPage(${entity.className} ${entity.lowerClassName}, Page pageInfo){\r\n    	Criteria criteria = getSession().createCriteria(${entity.className}.class).setFirstResult(pageInfo.getStartIndex()).setMaxResults(pageInfo.getNumPerPage());\r\n        addQueryCause(criteria,${entity.lowerClassName});\r\n        if(pageInfo.getOrderField()!=null && !pageInfo.getOrderField().trim().equals(\"\")){\r\n         	if(pageInfo.getOrderDirection()==null || pageInfo.getOrderDirection().trim().equals(\"asc\")){\r\n         		criteria.addOrder(Order.asc(pageInfo.getOrderField()));\r\n         	}else{\r\n         		criteria.addOrder(Order.desc(pageInfo.getOrderField()));\r\n         	}\r\n         }else{\r\n         	criteria.addOrder(Order.asc(\"${entity.idColumnName}\")); \r\n         }\r\n        return criteria.list();\r\n    }\r\n    \r\n    private void addQueryCause(Criteria criteria,${entity.className} ${entity.lowerClassName}){\r\n    	 #{ADD_CAUSE_ON_CRITERIA}\r\n    }\r\n\r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('13', 'Entity', 'package ${entity.currentFileFullPackage};\r\n${entity.classComment}\r\n@Entity\r\n<c:choose>\r\n<c:when test=\"${not empty entity.tableName}\">\r\n@Table(name=\"${entity.tableName}\")\r\n</c:when>\r\n<c:otherwise>\r\n@Table(name=\"t_${entity.lowerClassName}\")\r\n</c:otherwise>\r\n</c:choose>\r\npublic class ${entity.className}{\r\n<c:if test=\"${entity.idGenerateType==0}\">\r\nprivate Integer id;\r\npublic void setId(Integer id){this.id=id;}\r\n@Id\r\n@GeneratedValue(strategy=GenerationType.AUTO)\r\n@Column(columnDefinition=\"integer\")\r\npublic Integer getId(){return this.id;}\r\n</c:if>\r\n\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n#{VALIDATE_ANNOTATION}\r\nprivate ${p.dataTypeName} ${p.propName};// ${p.name}\r\n<c:if test=\"${p.forQuery==1 and (p.dataType==2 or p.dataType==3 or p.dataType==4)}\">\r\nprivate ${p.dataTypeName} ${p.propName}Start;\r\nprivate ${p.dataTypeName} ${p.propName}End;\r\n</c:if>\r\n</c:forEach>\r\n\r\n\r\n//getter and setter ...\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\npublic void ${p.setterName}(${p.dataTypeName} ${p.propName}){\r\n    this.${p.propName} = ${p.propName};\r\n}\r\n#{JPA_ANNOTATION}\r\npublic ${p.dataTypeName} ${p.getterName}(){\r\n    return this.${p.propName};\r\n}\r\n<c:if test=\"${p.forQuery==1 and (p.dataType==2 or p.dataType==3 or p.dataType==4)}\">\r\npublic void ${p.setterName}Start(${p.dataTypeName} ${p.propName}Start){\r\n    this.${p.propName}Start = ${p.propName}Start;\r\n}\r\n@Transient\r\npublic ${p.dataTypeName} ${p.getterName}Start(){\r\n    return this.${p.propName}Start;\r\n}\r\npublic void ${p.setterName}End(${p.dataTypeName} ${p.propName}End){\r\n    this.${p.propName}End = ${p.propName}End;\r\n}\r\n@Transient\r\npublic ${p.dataTypeName} ${p.getterName}End(){\r\n    return this.${p.propName}End;\r\n}\r\n</c:if>\r\n</c:forEach>\r\n\r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('14', 'Enum类型', 'package ${entity.currentFileFullPackage};\r\nimport java.util.LinkedHashMap;\r\nimport java.util.Map;\r\n/*\r\n * ${entity.name}\r\n * @author auto created by pc\r\n * <fmt:formatDate value=\"${NOW}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\npublic enum ${entity.className}{\r\n    ${entity.str2Enum}\r\n    private String description;\r\n    private ${entity.className}(String description){this.description = description;}\r\n    public String getDescription(){return description;}\r\n    public final static Map<${entity.className},String> ${entity.lowerClassName}Map = new LinkedHashMap<${entity.className},String>();\r\n    static{\r\n        for(${entity.className} s : ${entity.className}.values()){\r\n          ${entity.lowerClassName}Map.put(s,s.getDescription());  \r\n        }\r\n    }\r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('15', 'PropertyEditor', 'package ${entity.fullPackageName}.propertyeditor;\r\nimport java.beans.PropertyEditorSupport;\r\n\r\npublic class ${entity.className}Editor extends PropertyEditorSupport{\r\n    public I${entity.className}Service ${entity.lowerClassName}Service;\r\n    public ${entity.className}Editor(I${entity.className}Service ${entity.lowerClassName}Service){\r\n        this.${entity.lowerClassName}Service = ${entity.lowerClassName}Service;\r\n    }\r\n    public String getAsText(){\r\n        ${entity.className} ${entity.lowerClassName} = (${entity.className})getValue();\r\n        if(${entity.lowerClassName}==null){\r\n            return \"\";\r\n        }\r\n        return String.valueOf(${entity.lowerClassName}.${entity.idCoumunGetterName}());\r\n    }\r\n    <c:set value=\"${entity.idColumnProp}\" var=\"idprop\"/>\r\n    public void setAsText(String id)throws IllegalArgumentException {\r\n        ${entity.className} ${entity.lowerClassName} = new ${entity.className}();\r\n        <c:choose><c:when test=\"${empty idprop or idprop.dataType==2}\">\r\n            Integer integerId = null;\r\n            try {integerId = Integer.parseInt(id);} catch (Exception e) {}\r\n            ${entity.lowerClassName} = ${entity.lowerClassName}Service.getById(${entity.className}.class,integerId);\r\n        </c:when><c:otherwise>\r\n            ${entity.lowerClassName} = ${entity.lowerClassName}Service.getById(${entity.className}.class,id);\r\n        </c:otherwise></c:choose> \r\n        setValue(${entity.lowerClassName});\r\n    }\r\n}', '1', '2');
INSERT INTO `t_template` VALUES ('16', '权限菜单SQL文件', '#${entity.name}-----------------------------------------------\r\nINSERT INTO `sys_function_point` (`id`,`is_display`, `name`, `order_num`, `url`, `parent`)VALUES (\'${sql_menu_startId+(entityIteratorIndex-1)*5}\',1,\'${entity.name}管理\',\'${sql_menu_startId+(entityIteratorIndex-1)*5}\',\'${entity.lowerClassName}/list.do\',\'132\');\r\nINSERT INTO `sys_function_point` (`id`,`is_display`, `name`, `order_num`, `url`, `parent`)VALUES (\'${sql_menu_startId+(entityIteratorIndex-1)*5+1}\',0,\'${entity.name}列表\',\'3\',\'${entity.lowerClassName}/list.do\',\'${sql_menu_startId+(entityIteratorIndex-1)*5}\');\r\nINSERT INTO `sys_function_point` (`id`,`is_display`, `name`, `order_num`, `url`, `parent`)VALUES (\'${sql_menu_startId+(entityIteratorIndex-1)*5+2}\',0,\'${entity.name}添加\',\'1\',\'${entity.lowerClassName}/add.do\',\'${sql_menu_startId+(entityIteratorIndex-1)*5}\');\r\nINSERT INTO `sys_function_point` (`id`,`is_display`, `name`, `order_num`, `url`, `parent`)VALUES (\'${sql_menu_startId+(entityIteratorIndex-1)*5+3}\',0,\'删除${entity.name}\',\'2\',\'${entity.lowerClassName}/delete.do\',\'${sql_menu_startId+(entityIteratorIndex-1)*5}\');\r\nINSERT INTO `sys_function_point` (`id`,`is_display`, `name`, `order_num`, `url`, `parent`)VALUES (\'${sql_menu_startId+(entityIteratorIndex-1)*5+4}\',0,\'${entity.name}修改\',\'3\',\'${entity.lowerClassName}/update.do\',\'${sql_menu_startId+(entityIteratorIndex-1)*5}\');\r\n\r\n', null, '2');
INSERT INTO `t_template` VALUES ('17', 'SHJQuery:添加页面', '[_LT]%@ page language=\"java\" contentType=\"text/html; charset=utf-8\"\r\n	pageEncoding=\"utf-8\"%[_GT]\r\n[_LT]%@include file=\"/WEB-INF/jsp/public/forAll.jsp\"%[_GT]\r\n[_LT]html[_GT]\r\n	[_LT]head[_GT]\r\n		[_LT]title[_GT]添加${entity.name}-${entity.name}管理[_LT]/title[_GT]\r\n		[_LT]%@include file=\"/WEB-INF/jsp/public/jqueryValidate.jsp\"%[_GT]\r\n	[_LT]/head[_GT]\r\n	[_LT]body class=\"ui-widget-content\" style=\"border:0\"[_GT]\r\n	[_LT]!-- 标题:开始 --[_GT]\r\n	[_LT]table width=\"100%\"[_GT]  \r\n	  [_LT]tr style=\"border:1px solid red\"[_GT]\r\n		  [_LT]td class=\"ui-icon ui-icon-circle-triangle-e\" width=\"16px\"[_GT]&nbsp;[_LT]/td[_GT]\r\n		  [_LT]td[_GT]添加${entity.name}[_LT]/td[_GT]\r\n	  [_LT]/tr[_GT]\r\n	[_LT]/table[_GT]\r\n	[_LT]!-- 标题:结束 --[_GT]\r\n	\r\n	[_LT]form:form method=\"post\" action=\"[_D]{basePath}${entity.lowerClassName}/add.do\"\r\n		class=\"pageForm required-validate\" commandName=\"${entity.lowerClassName}\"\r\n		id=\"formID\"[_GT]\r\n		[_LT]input type=\"hidden\" value=\"[_D]{rel}\" name=\"rel\" /[_GT]\r\n		\r\n		[_LT]div id=\"TableTail\"[_GT]\r\n       	    [_LT]div id=\"TableTail_inside\"[_GT]\r\n       	    	\r\n       	    	[_LT]table[_GT]\r\n					#{SHJqueryUI_ADD_INPUT_TRS}\r\n       	    	[_LT]/table[_GT]\r\n       	    [_LT]/div[_GT]\r\n       	[_LT]/div[_GT]\r\n		\r\n		[_LT]div id=\"InputDetailBar\"[_GT]\r\n			[_LT]input type=\"submit\" value=\"保存\"[_GT]\r\n			[_LT]input type=\"button\" value=\"取消\" onclick=\"window.history.go(-1);\"[_GT]\r\n		[_LT]/div[_GT]\r\n	[_LT]/form:form[_GT]\r\n\r\n	[_LT]/body[_GT]\r\n[_LT]/html[_GT]', '3', '1');
INSERT INTO `t_template` VALUES ('18', 'SHJQuery:修改页面', '[_LT]%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%[_GT]\r\n[_LT]%@include file=\"/WEB-INF/jsp/public/forAll.jsp\"%[_GT]\r\n[_LT]html[_GT]\r\n	[_LT]head[_GT]\r\n		[_LT]title[_GT]修改${entity.name}-${entity.name}管理[_LT]/title[_GT]\r\n		[_LT]%@include file=\"/WEB-INF/jsp/public/jqueryValidate.jsp\"%[_GT]\r\n	[_LT]/head[_GT]\r\n	[_LT]body class=\"ui-widget-content\" style=\"border:0\"[_GT]\r\n	[_LT]!-- 标题:开始 --[_GT]\r\n	[_LT]table width=\"100%\"[_GT]  \r\n	  [_LT]tr style=\"border:1px solid red\"[_GT]\r\n		  [_LT]td class=\"ui-icon ui-icon-circle-triangle-e\" width=\"16px\"[_GT]&nbsp;[_LT]/td[_GT]\r\n		  [_LT]td[_GT]修改${entity.name}[_LT]/td[_GT]\r\n	  [_LT]/tr[_GT]\r\n	[_LT]/table[_GT]\r\n	[_LT]!-- 标题:结束 --[_GT]\r\n		[_LT]form:form method=\"post\" action=\"[_D]{basePath}${entity.lowerClassName}/update.do\" class=\"pageForm required-validate\" commandName=\"${entity.lowerClassName}\"\r\n		id=\"formID\"[_GT]\r\n		[_LT]form:input type=\"hidden\" path=\"${empty entity.idColumnProp ? \'id\' : entity.idColumnProp.propName}\"/[_GT]\r\n		[_LT]div id=\"TableTail\"[_GT]\r\n       	    [_LT]div id=\"TableTail_inside\"[_GT]\r\n       	    	[_LT]table[_GT]\r\n       	    		#{SHJqueryUI_UPDATE_INPUT_TRS}\r\n       	    	[_LT]/table[_GT]\r\n       	    [_LT]/div[_GT]\r\n       	[_LT]/div[_GT]\r\n		[_LT]div id=\"InputDetailBar\"[_GT]\r\n			[_LT]input type=\"submit\" value=\"保存\"[_GT]\r\n			[_LT]input type=\"button\" value=\"取消\" onclick=\"window.history.go(-1);\"[_GT]\r\n		[_LT]/div[_GT]\r\n	[_LT]/form:form[_GT]\r\n\r\n	[_LT]/body[_GT]\r\n[_LT]/html[_GT]	', '3', '1');
INSERT INTO `t_template` VALUES ('19', 'SHJQuery:列表页面', '[_LT]%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%[_GT]\r\n[_LT]%@include file=\"/WEB-INF/jsp/public/forAll.jsp\"%[_GT]\r\n[_LT]html[_GT]\r\n	[_LT]head[_GT]\r\n		[_LT]title[_GT]${entity.name}列表-${entity.name}管理[_LT]/title[_GT]\r\n		[_LT]%@include file=\"/WEB-INF/jsp/public/forList.jsp\"%[_GT]\r\n	[_LT]/head[_GT]\r\n[_LT]body class=\"ui-widget-content\" style=\"border:0\"[_GT]\r\n	[_LT]!-- 标题:开始 --[_GT]\r\n	[_LT]table width=\"100%\"[_GT]  \r\n	  [_LT]tr style=\"border:1px solid red\"[_GT]\r\n		  [_LT]td class=\"ui-icon ui-icon-circle-triangle-e\" width=\"16px\"[_GT]&nbsp;[_LT]/td[_GT]\r\n		  [_LT]td[_GT]${entity.name}列表[_LT]/td[_GT]\r\n	  [_LT]/tr[_GT]\r\n	[_LT]/table[_GT]\r\n	[_LT]!-- 标题:结束 --[_GT]\r\n	\r\n	[_LT]!-- 页面菜单：开始 --[_GT]\r\n	[_LT]table border=\"0\" style=\"position:absolute;top:0;right:0;\"[_GT]\r\n		    [_LT]tr[_GT]\r\n		    	[_LT]n:pv url=\"user/add.do\"[_GT]\r\n					[_LT]td[_GT]&nbsp;[_LT]/td[_GT]\r\n					[_LT]td class=\"ui-icon ui-icon-circle-plus\"[_GT][_LT]/td[_GT]\r\n					[_LT]td[_GT]\r\n						[_LT]span[_GT][_LT]a href=\"[_D]{basePath}${entity.lowerClassName}/add.do\"[_GT]添加[_LT]/a[_GT][_LT]/span[_GT] \r\n					[_LT]/td[_GT] \r\n		    	[_LT]/n:pv[_GT]\r\n				[_LT]%--\r\n	[_LT]n:pv url=\"${entity.lowerClassName}/delete.do\"[_GT]\r\n				[_LT]td[_GT]&nbsp;[_LT]/td[_GT]\r\n				[_LT]td class=\"ui-icon ui-icon-trash\"[_GT][_LT]/td[_GT]\r\n				[_LT]td[_GT]\r\n					[_LT]a href=\"${entity.lowerClassName}/delete.do\" onclick=\"return operation(\'delete\',\'listForm\',\'${entity.lowerClassName}/delete.do\',\'ids\')\"[_GT]删除[_LT]/a[_GT]\r\n				[_LT]/td[_GT]\r\n	[_LT]/n:pv[_GT]\r\n				 --%[_GT]\r\n			[_LT]/tr[_GT]\r\n	[_LT]/table[_GT]\r\n	[_LT]!-- 页面菜单：结束--[_GT]	\r\n		[_LT]form:form onsubmit=\"return navTabSearch(this);\" action=\"[_D]{basePath}${entity.lowerClassName}/list.do\"\r\n	 method=\"post\" commandName=\"${entity.lowerClassName}\" id=\"listForm\"[_GT]\r\n			[_LT]div id=\"TableTail\"[_GT]\r\n       	    [_LT]div id=\"TableTail_inside\"[_GT]\r\n       	    [_LT]!-- 查询栏：开始 --[_GT]\r\n			[_LT]input type=\"hidden\" name=\"pageNum\" value=\"[_D]{pageBean.pageNum}\" /[_GT]\r\n			[_LT]input type=\"hidden\" name=\"rel\" value=\"[_D]{rel}\" /[_GT]\r\n			[_LT]input type=\"hidden\" name=\"orderField\" value=\"[_D]{pageBean.orderField}\" /[_GT]\r\n			[_LT]input type=\"hidden\" name=\"orderDirection\" value=\"[_D]{pageBean.orderDirection}\" /[_GT]\r\n			[_LT]table[_GT]	\r\n			#{SHJqueryUI_Query_Table}\r\n			[_LT]tr[_GT]\r\n				[_LT]td colspan=\"2\"[_GT][_LT]input type=\"submit\" value=\"查询\"[_GT][_LT]/td[_GT]\r\n			[_LT]/tr[_GT]\r\n			[_LT]/table[_GT]\r\n			[_LT]!-- 查询栏：结束 --[_GT]\r\n			[_LT]/div[_GT]\r\n	[_LT]/div[_GT]\r\n		[_LT]!-- 列表TABLE：开始 --[_GT]\r\n		[_LT]table class=\"ui-widget ui-widget-content\" width=\"100%\" border=\"0\"[_GT]\r\n			[_LT]thead[_GT]\r\n				[_LT]tr class=\"ui-widget-header\" height=\"30px\" id=\"listTHead\"[_GT]\r\n					#{SHJqueryUI_HEAD_TDS}\r\n				[_LT]/tr[_GT]\r\n			[_LT]/thead[_GT]\r\n			[_LT]tbody id=\"listTBody\"[_GT]\r\n			[_LT]c:if test=\"[_D]{empty pageBean.list}\"[_GT]\r\n				[_LT]tr height=\"25px\"[_GT]\r\n					[_LT]td  colspan=\"${fn:length(entity.properties)}\" align=\"center\"[_GT]\r\n						[_LT]font style=\"color: gray\"[_GT][_LT]b[_GT]暂无数据[_LT]/b[_GT]\r\n						[_LT]/font[_GT]\r\n					[_LT]/td[_GT]\r\n				[_LT]/tr[_GT]\r\n			[_LT]/c:if[_GT]\r\n			[_LT]c:forEach items=\"[_D]{pageBean.list}\" var=\"temp${entity.lowerClassName}\"[_GT]\r\n				[_LT]tr height=\"25px\"[_GT]\r\n						#{SHJqueryUI_Body_TDS}\r\n				[_LT]/tr[_GT]\r\n			[_LT]/c:forEach[_GT]\r\n			[_LT]/tbody[_GT]\r\n		[_LT]/table[_GT]  \r\n		[_LT]!-- 列表TABLE：结束--[_GT]\r\n		[_LT]!-- 分页条：开始 --[_GT]\r\n		[_LT]jsp:include page=\"/WEB-INF/jsp/public/pageBar.jsp\" /[_GT]\r\n		[_LT]!-- 分页条：结束 --[_GT]\r\n		[_LT]!-- 功能按钮：开始--[_GT]\r\n		[_LT]div id=\"InputDetailBar\"[_GT]\r\n		\r\n		[_LT]/div[_GT]\r\n		[_LT]!-- 功能按钮：结束 --[_GT]\r\n	[_LT]/form:form[_GT]\r\n[_LT]/body[_GT]', '3', '1');
INSERT INTO `t_template` VALUES ('20', 'SHJQuery:Controller', 'package ${entity.currentFileFullPackage};\r\n\r\nimport java.util.Date;\r\nimport java.util.List;\r\n\r\nimport javax.annotation.Resource;\r\nimport javax.servlet.http.HttpServletRequest;\r\nimport javax.servlet.http.HttpSession;\r\nimport javax.validation.Valid;\r\n\r\nimport org.springframework.beans.factory.annotation.Autowired;\r\nimport org.springframework.stereotype.Controller;\r\nimport org.springframework.validation.BindingResult;\r\nimport org.springframework.validation.Errors;\r\nimport org.springframework.validation.FieldError;\r\nimport org.springframework.validation.Validator;\r\nimport org.springframework.web.bind.WebDataBinder;\r\nimport org.springframework.web.bind.annotation.InitBinder;\r\nimport org.springframework.web.bind.annotation.ModelAttribute;\r\nimport org.springframework.web.bind.annotation.PathVariable;\r\nimport org.springframework.web.bind.annotation.RequestMapping;\r\nimport org.springframework.web.bind.annotation.RequestMethod;\r\nimport org.springframework.web.bind.annotation.RequestParam;\r\nimport org.springframework.web.bind.annotation.ResponseBody;\r\n\r\nimport com.lenovots.jdhr.common.entity.enumtype.YesNo;\r\nimport com.lenovots.jdhr.employee.entity.Employee;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.Degree;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.DimissReason;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.DimissType;\r\nimport com.lenovots.jdhr.employee.entity.enumtype.Sex;\r\nimport com.lenovots.jdhr.hr.entity.HrResource;\r\nimport com.lenovots.jdhr.system.entity.FunctionPoint;\r\nimport com.lenovots.jdhr.system.entity.propertyeditor.FunctionPointEditor;\r\nimport com.lenovots.jdhr.util.web.JsonResult;\r\n\r\n/**\r\n * ${entity.name}Controller auto created by pc\r\n * @author pc\r\n * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\n@Controller\r\n@RequestMapping(\"/${entity.lowerClassName}\")\r\npublic class ${entity.className}Controller extends BaseController {\r\n\r\n    @Resource\r\n    private I${entity.className}Service ${entity.lowerClassName}Service;\r\n    \r\n    @InitBinder\r\n	public void initPropEditor(WebDataBinder binder){\r\n    	    //注册属性编辑器\r\n	    #{INIT_PROP_EDITOR}\r\n	}\r\n    \r\n    //复杂关联关系的Service\r\n    #{COMPLEX_SERVICES_DEFINE}\r\n    \r\n    @ModelAttribute\r\n    public ${entity.className} initModelAttribute(@RequestParam(value=\"${entity.idColumnName}\",required=false) ${empty entity.idColumnProp ? \'Integer\':entity.idColumnProp.dataTypeName} ${entity.idColumnName}){\r\n    	${entity.className} ${entity.lowerClassName} = null;\r\n    	if(${entity.idColumnName}==null || ${entity.idColumnName}.equals(\"\")){\r\n    		${entity.lowerClassName} = new ${entity.className}();\r\n    	}else{\r\n    		${entity.lowerClassName} = ${entity.lowerClassName}Service.getById(${entity.className}.class, ${entity.idColumnName});\r\n    	}\r\n    	return ${entity.lowerClassName};\r\n    }\r\n    \r\n    /**\r\n     * ${entity.name}列表\r\n     * @param request\r\n     * @return\r\n     * @author pc\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/list\")\r\n    public void list(HttpServletRequest request,${entity.className} ${entity.lowerClassName},Page pageInfo) {\r\n        Page<${entity.className}> ${entity.lowerClassName}Page = ${entity.lowerClassName}Service.getListPage(${entity.lowerClassName},pageInfo);\r\n        request.setAttribute(\"pageBean\", ${entity.lowerClassName}Page);\r\n        //复杂关联关系数据准备\r\n    	#{COMPLEX_LIST_PREPARE}\r\n    }\r\n    \r\n    /**\r\n     * 添加${entity.name}页面\r\n     * @param request\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/add\",method=RequestMethod.GET)\r\n    public void addUI(HttpServletRequest request) {\r\n    	//复杂关联关系数据准备\r\n        #{COMPLEX_LIST_PREPARE}\r\n    }\r\n    \r\n    /**\r\n     * 添加ENTITY_REALY_NAME\r\n     * @param ${entity.lowerClassName}\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/add\",method=RequestMethod.POST)\r\n    //@ResponseBody\r\n    public String add(@Valid @ModelAttribute(\"${entity.lowerClassName}\") ${entity.className} ${entity.lowerClassName},BindingResult result) {\r\n    	JsonResult jsonResult = new JsonResult();\r\n    	//if(!validate(jsonResult,result)){\r\n    	//	return jsonResult;\r\n    	//}\r\n    	//默认系统时间类型保存\r\n    	#{DATATYPE_DEFAULT_VALUE_SAVE}\r\n    	${entity.lowerClassName}Service.add(${entity.lowerClassName});\r\n    	jsonResult.setMessage(\"添加成功\");\r\n		return \"redirect:list.do\";\r\n    }\r\n    \r\n    /**\r\n     * 修改ENTITY_REALY_NAME页面\r\n     * @param uid\r\n     * @param request\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/update\",method=RequestMethod.GET)\r\n	public void updateUI(@RequestParam(value=\"${empty entity.idColumnProp ? \'id\' : entity.idColumnProp.propName}\") ${empty entity.idColumnProp ? \'Integer\' : entity.idColumnProp.dataTypeName} ${empty entity.idColumnProp ? \'id\' : entity.idColumnProp.propName},HttpServletRequest request) {\r\n    	//复杂关联关系数据准备\r\n        #{COMPLEX_LIST_PREPARE}\r\n    }\r\n    \r\n    /**\r\n     * 修改${entity.name}\r\n     * @param ${entity.lowerClassName}\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/update\",method=RequestMethod.POST)\r\n    //@ResponseBody\r\n    public String update(HttpServletRequest request,@ModelAttribute ${entity.className} ${entity.lowerClassName},BindingResult result) {\r\n    	JsonResult jsonResult = new JsonResult();\r\n    	if(!validate(jsonResult,result)){\r\n			request.setAttribute(\"jsonResult\",jsonResult);\r\n			return \"message\";\r\n    	}\r\n        ${entity.lowerClassName}Service.update(${entity.lowerClassName});\r\n        jsonResult.setMessage(\"修改成功\");\r\n        return \"redirect:list.do\";\r\n    }\r\n    \r\n    /**\r\n     * 删除单个\r\n     * @param uid\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n     */\r\n    @RequestMapping(value=\"/delete\",method=RequestMethod.GET)\r\n	//@ResponseBody\r\n    public String delete(HttpServletRequest request,@ModelAttribute ${entity.className} ${entity.lowerClassName}) {\r\n        JsonResult jsonResult = new JsonResult();\r\n        jsonResult.setCallbackType(\"\");\r\n        try {\r\n        	${entity.lowerClassName}Service.delete(${entity.lowerClassName});\r\n		} catch (RuntimeException re) {\r\n			jsonResult.setMessage(\"该记录已被使用，不能删除！\");\r\n			request.setAttribute(\"jsonResult\",jsonResult);\r\n			return \"message\";\r\n		}catch (Exception e) {\r\n			jsonResult.setMessage(e.toString());\r\n			request.setAttribute(\"jsonResult\",jsonResult);\r\n			return \"message\";\r\n		}\r\n        jsonResult.setMessage(\"删除成功\");\r\n        return \"redirect:list.do\";\r\n    }\r\n    \r\n	@RequestMapping(value = \"/detail\", method = RequestMethod.GET)\r\n	public void detailUI(@ModelAttribute ${entity.className} ${entity.lowerClassName},HttpServletRequest request) {\r\n		#{COMPLEX_LIST_PREPARE}\r\n	}\r\n	\r\n    /**\r\n     * 删除多个\r\n     * @param uids\r\n     * @return\r\n     * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n   \r\n    @RequestMapping(value=\"/delete\",method=RequestMethod.POST)\r\n	//@ResponseBody\r\n    public String batchDelete(@RequestParam(\"ID_PROPERTY_NAMEs\") ID_PROPERTY_DATATYPENAME[] ID_PROPERTY_NAMEs) {\r\n    	${entity.className} ${entity.lowerClassName} = null;\r\n    	for(ID_PROPERTY_DATATYPENAME id : ID_PROPERTY_NAMEs){\r\n    		${entity.lowerClassName} = ${entity.lowerClassName}Service.loadById(${entity.className}.class, id);\r\n    		${entity.lowerClassName}Service.delete(${entity.lowerClassName});\r\n    	}\r\n    	JsonResult jsonResult = new JsonResult();\r\n    	jsonResult.setMessage(\"删除成功\");\r\n		return \"redirect:list.do\";\r\n    } \r\n    */\r\n    \r\n}', '3', '2');
INSERT INTO `t_template` VALUES ('21', 'SHJQuery:Service接口', 'package ${entity.currentFileFullPackage};\r\n\r\nimport com.lenovots.demo.func.service.PageInfo;\r\n\r\nimport ${entity.fullClassName};\r\n/**\r\n * ${entity.name}Service接口\r\n * @author \r\n *  <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\npublic interface I${entity.className}Service extends IBaseService<${entity.className}> {\r\n\r\n    /**\r\n     * 得到分页信息\r\n     * @param role\r\n     * @return\r\n     */\r\n    public Page<${entity.className}> getListPage(${entity.className} ${entity.lowerClassName},Page pageInfo);\r\n}', '3', '2');
INSERT INTO `t_template` VALUES ('22', 'SHJQuery:Service实现', 'package ${entity.currentFileFullPackage};\r\n\r\nimport java.util.List;\r\n\r\nimport javax.annotation.Resource;\r\nimport org.springframework.stereotype.Service;\r\n\r\nimport com.lenovots.jdhr.util.web.Page;\r\n\r\nimport ${entity.fullClassName};\r\n\r\n\r\n/**\r\n * ${entity.name}实现\r\n * @author \r\n * <fmt:formatDate value=\"${now}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\n@Service\r\npublic class ${entity.className}ServiceImpl extends BaseServiceImpl<${entity.className}> implements I${entity.className}Service {\r\n\r\n    @Resource\r\n    private I${entity.className}Dao ${entity.lowerClassName}Dao;\r\n    \r\n    @Override\r\n    public Page<${entity.className}> getListPage(${entity.className} ${entity.lowerClassName},Page pageInfo) {\r\n      	pageInfo.setTotalCount(${entity.lowerClassName}Dao.findListRowCount(${entity.lowerClassName}).intValue());\r\n		pageInfo.setOrderField(pageInfo.getOrderField() == null ? \"id\": pageInfo.getOrderField());\r\n		pageInfo.setOrderDirection(pageInfo.getOrderDirection() == null ? \"asc\": pageInfo.getOrderDirection());\r\n		pageInfo.setList(${entity.lowerClassName}Dao.findListPage(${entity.lowerClassName},pageInfo));\r\n        return pageInfo;\r\n    }\r\n}', '3', '2');
INSERT INTO `t_template` VALUES ('23', 'SHJQuery:Dao接口', 'package ${entity.currentFileFullPackage};\r\nimport java.util.List;\r\n\r\nimport com.lenovots.jdhr.employee.entity.EmployeeAttribute;\r\n\r\nimport ${entity.fullClassName};\r\n/**\r\n * ${entity.name}接口\r\n * @author auto created by pc\r\n * <fmt:formatDate value=\"${NOW}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\npublic interface I${entity.className}Dao extends IBaseDao<${entity.className}> {\r\n\r\n    /**\r\n     * 查询记录数\r\n     * @param role\r\n     * @return\r\n     */\r\n	Long findListRowCount(${entity.className} ${entity.lowerClassName});\r\n\r\n    /**\r\n     * 分页查询角色信息\r\n     * @param role\r\n     * @return\r\n     */\r\n    List<${entity.className}> findListPage(${entity.className} ${entity.lowerClassName}, Page pageInfo);\r\n}', '3', '2');
INSERT INTO `t_template` VALUES ('24', 'SHJQuery:Dao实现', 'package ${entity.currentFileFullPackage};\r\nimport java.util.List;\r\n\r\nimport org.hibernate.Criteria;\r\nimport org.hibernate.criterion.MatchMode;\r\nimport org.hibernate.criterion.Order;\r\nimport org.hibernate.criterion.Projections;\r\nimport org.hibernate.criterion.Restrictions;\r\nimport org.springframework.stereotype.Repository;\r\n\r\nimport ${entity.fullClassName};\r\n/**\r\n * ${entity.name}Dao实现\r\n * @author auto created by pc\r\n * <fmt:formatDate value=\"${NOW}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\n@Repository\r\npublic class ${entity.className}DaoImpl extends BaseDaoImpl<${entity.className}> implements I${entity.className}Dao {\r\n\r\n    @Override\r\n    public Long findListRowCount(${entity.className} ${entity.lowerClassName}) {\r\n        Criteria criteria = getSession().createCriteria(${entity.className}.class).setProjection(Projections.rowCount());\r\n        addQueryCause(criteria,${entity.lowerClassName});\r\n        return (Long) criteria.uniqueResult();\r\n    }\r\n\r\n    @SuppressWarnings(\"unchecked\")\r\n    @Override\r\n    public List<${entity.className}> findListPage(${entity.className} ${entity.lowerClassName}, Page pageInfo){\r\n    	Criteria criteria = getSession().createCriteria(${entity.className}.class).setFirstResult(pageInfo.getStartIndex()).setMaxResults(pageInfo.getNumPerPage());\r\n        addQueryCause(criteria,${entity.lowerClassName});\r\n        if(pageInfo.getOrderField()!=null && !pageInfo.getOrderField().trim().equals(\"\")){\r\n         	if(pageInfo.getOrderDirection()==null || pageInfo.getOrderDirection().trim().equals(\"asc\")){\r\n         		criteria.addOrder(Order.asc(pageInfo.getOrderField()));\r\n         	}else{\r\n         		criteria.addOrder(Order.desc(pageInfo.getOrderField()));\r\n         	}\r\n         }else{\r\n         	criteria.addOrder(Order.asc(\"${entity.idColumnName}\")); \r\n         }\r\n        return criteria.list();\r\n    }\r\n    \r\n    private void addQueryCause(Criteria criteria,${entity.className} ${entity.lowerClassName}){\r\n    	 #{ADD_CAUSE_ON_CRITERIA}\r\n    }\r\n\r\n}', '3', '2');
INSERT INTO `t_template` VALUES ('25', 'SHJQuery:Entity', 'package ${entity.currentFileFullPackage};\r\n${entity.classComment}\r\n@Entity\r\n<c:choose>\r\n<c:when test=\"${not empty entity.tableName}\">\r\n@Table(name=\"${entity.tableName}\")\r\n</c:when>\r\n<c:otherwise>\r\n@Table(name=\"t_${entity.lowerClassName}\")\r\n</c:otherwise>\r\n</c:choose>\r\npublic class ${entity.className}{\r\n<c:if test=\"${entity.idGenerateType==0}\">\r\nprivate Integer id;\r\npublic void setId(Integer id){this.id=id;}\r\n@Id\r\n@GeneratedValue(strategy=GenerationType.AUTO)\r\n@Column(columnDefinition=\"integer\")\r\npublic Integer getId(){return this.id;}\r\n</c:if>\r\n\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n#{VALIDATE_ANNOTATION}\r\nprivate ${p.dataTypeName} ${p.propName};// ${p.name}\r\n<c:if test=\"${p.forQuery==1 and (p.dataType==2 or p.dataType==3 or p.dataType==4)}\">\r\nprivate ${p.dataTypeName} ${p.propName}Start;\r\nprivate ${p.dataTypeName} ${p.propName}End;\r\n</c:if>\r\n</c:forEach>\r\n\r\n\r\n//getter and setter ...\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\npublic void ${p.setterName}(${p.dataTypeName} ${p.propName}){\r\n    this.${p.propName} = ${p.propName};\r\n}\r\n#{JPA_ANNOTATION}\r\npublic ${p.dataTypeName} ${p.getterName}(){\r\n    return this.${p.propName};\r\n}\r\n<c:if test=\"${p.forQuery==1 and (p.dataType==2 or p.dataType==3 or p.dataType==4)}\">\r\npublic void ${p.setterName}Start(${p.dataTypeName} ${p.propName}Start){\r\n    this.${p.propName}Start = ${p.propName}Start;\r\n}\r\n@Transient\r\npublic ${p.dataTypeName} ${p.getterName}Start(){\r\n    return this.${p.propName}Start;\r\n}\r\npublic void ${p.setterName}End(${p.dataTypeName} ${p.propName}End){\r\n    this.${p.propName}End = ${p.propName}End;\r\n}\r\n@Transient\r\npublic ${p.dataTypeName} ${p.getterName}End(){\r\n    return this.${p.propName}End;\r\n}\r\n</c:if>\r\n</c:forEach>\r\n\r\n}', '3', '2');
INSERT INTO `t_template` VALUES ('26', 'SHJQuery:Enum枚举', 'package ${entity.currentFileFullPackage};\r\nimport java.util.LinkedHashMap;\r\nimport java.util.Map;\r\n/*\r\n * ${entity.name}\r\n * @author auto created by pc\r\n * <fmt:formatDate value=\"${NOW}\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>\r\n */\r\npublic enum ${entity.className}{\r\n    ${entity.str2Enum}\r\n    private String description;\r\n    private ${entity.className}(String description){this.description = description;}\r\n    public String getDescription(){return description;}\r\n    public final static Map<${entity.className},String> ${entity.lowerClassName}Map = new LinkedHashMap<${entity.className},String>();\r\n    static{\r\n        for(${entity.className} s : ${entity.className}.values()){\r\n          ${entity.lowerClassName}Map.put(s,s.getDescription());  \r\n        }\r\n    }\r\n}', '3', '2');
INSERT INTO `t_template` VALUES ('27', 'SHJQuery:PropertyEditor', 'package ${entity.fullPackageName}.propertyeditor;\r\nimport java.beans.PropertyEditorSupport;\r\n\r\npublic class ${entity.className}Editor extends PropertyEditorSupport{\r\n    public I${entity.className}Service ${entity.lowerClassName}Service;\r\n    public ${entity.className}Editor(I${entity.className}Service ${entity.lowerClassName}Service){\r\n        this.${entity.lowerClassName}Service = ${entity.lowerClassName}Service;\r\n    }\r\n    public String getAsText(){\r\n        ${entity.className} ${entity.lowerClassName} = (${entity.className})getValue();\r\n        if(${entity.lowerClassName}==null){\r\n            return \"\";\r\n        }\r\n        return String.valueOf(${entity.lowerClassName}.${entity.idCoumunGetterName}());\r\n    }\r\n    <c:set value=\"${entity.idColumnProp}\" var=\"idprop\"/>\r\n    public void setAsText(String id)throws IllegalArgumentException {\r\n        ${entity.className} ${entity.lowerClassName} = new ${entity.className}();\r\n        <c:choose><c:when test=\"${empty idprop or idprop.dataType==2}\">\r\n            Integer integerId = null;\r\n            try {integerId = Integer.parseInt(id);} catch (Exception e) {}\r\n            ${entity.lowerClassName} = ${entity.lowerClassName}Service.getById(${entity.className}.class,integerId);\r\n        </c:when><c:otherwise>\r\n            ${entity.lowerClassName} = ${entity.lowerClassName}Service.getById(${entity.className}.class,id);\r\n        </c:otherwise></c:choose> \r\n        setValue(${entity.lowerClassName});\r\n    }\r\n}', '3', '2');

-- ----------------------------
-- Table structure for `t_templategroup`
-- ----------------------------
DROP TABLE IF EXISTS `t_templategroup`;
CREATE TABLE `t_templategroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_templategroup
-- ----------------------------
INSERT INTO `t_templategroup` VALUES ('1', 'springMVC+hibernate+DWZ');
INSERT INTO `t_templategroup` VALUES ('2', 'struts2+hibernate+spring');
INSERT INTO `t_templategroup` VALUES ('3', 'springMVC+hibernate+jqueryUI');

-- ----------------------------
-- Table structure for `t_varlabel`
-- ----------------------------
DROP TABLE IF EXISTS `t_varlabel`;
CREATE TABLE `t_varlabel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `remark` text,
  `category` int(11) DEFAULT NULL,
  `value` text,
  `projectId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6C5B8B9834F29F6` (`projectId`) USING BTREE,
  CONSTRAINT `t_varlabel_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `t_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_varlabel
-- ----------------------------
INSERT INTO `t_varlabel` VALUES ('1', 'entity.fullPackageName', '包名称:java文件第一行package后面的内容', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('2', 'entity.fullClassName', '对应实体类全称<br/>例如com.foo.entity.Student<br/>一般使用在import语句当中', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('3', 'entity.className', '简写正常实体名，如Student，一般在HQL语句中，如From Sutdent student中使用:<br/>\r\nFROM <b>${entity.className}</b> ${entity.lowerClassName}', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('4', 'entity.lowerClassName', '小写的Class名称，例如Student类的 lowerClassName为student,一般使用为model实体对象名称。', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('5', 'PAGE_TITLE_LIST', '列表页面标题', '1', '', null);
INSERT INTO `t_varlabel` VALUES ('6', 'PAGE_TITLE_ADD', '添加页面标题', '1', '', null);
INSERT INTO `t_varlabel` VALUES ('7', 'PAGE_TITLE_UPDATE', '修改页面标题', '1', '', null);
INSERT INTO `t_varlabel` VALUES ('8', 'PAGE_TITLE_IMPORT', '导入页面标题', '1', '', null);
INSERT INTO `t_varlabel` VALUES ('9', 'property.name', '字段显示名称，例如name字段的显示名称为“姓名”', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('10', 'property.propName', '字段名称，例如name的字段名称为name', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('11', 'PROPERTY_INPUT', '文本输入框', '1', '<li><label>PROPERTY_DISPLAY_NAME:</label><form:input path=\"PROPERTY_NAME\"/></li>', '10');
INSERT INTO `t_varlabel` VALUES ('12', 'ID', '实体主键', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('13', 'PROPERTY_ID', '属性的id，例如user中有role属性，此标签即表示role的id值', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('14', 'entity.tableName', '数据映射表名称，示例：@Table(name=\"${entity.tableName}\")', '0', 'fr', null);
INSERT INTO `t_varlabel` VALUES ('15', 'AUTO_INCREMENT_ID_ANNOTATION', '自增长主键', '1', '    @Id\r\n    @GeneratedValue\r\n    @GenericGenerator(strategy=\"increment\")\r\n    @Column(columnDefinition=\"integer\")', null);
INSERT INTO `t_varlabel` VALUES ('16', 'ASSIGNED_ID_ANNOTATION', '自指定类型主键', '1', '@GeneratedValue(generator = \"paymentableGenerator\")     \r\n@GenericGenerator(name = \"paymentableGenerator\", strategy = \"assigned\")  ', null);
INSERT INTO `t_varlabel` VALUES ('17', 'NOT_EMPTY_ANNOTATION', '不为空注解', '1', ' @NotEmpty(message=\"备注不能为空\")', null);
INSERT INTO `t_varlabel` VALUES ('18', '映射规则查询条件', '目前支持多个条件的与（AND）条件，每个查询条件用分号（;）分隔，例如:\r\n${entity.type}=0;${entity.className}=Student。以后的版本考虑支持括号、大于小于包含等复杂匹配方式', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('19', '上一级文件夹', '格式为<b style=\'color:red;font-size:16px\'>../</b>。例如：src.${entity.packagee.fullPackageName}../dao/impl，表示该符号之前所代表的文件夹的上级文件夹。', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('20', 'ADD_INPUT_TRS', '添加页面输入框', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n	<c:if test=\"${p.onlyRelationship!=1}\">\r\n\r\n		<c:choose>\r\n			<c:when test=\"${p.isTotalRow==1}\">\r\n				<dl class=\"nowrap\">\r\n					<dt>\r\n						${p.name}：\r\n					</dt>\r\n					<dd>\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}${p.dataType==2?\'digits\':\'number\'}\" />\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											cssClass=\"${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											maxlength=\"${p.length}\" />\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_${p.canNull==1?\'not_required textInput valid\':\'required textInput valid\'}\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"comboxed${p.canNull==1?\'\':\' required\'}\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${entity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\">\r\n								<option value=\\\"\\\">请选择</option>\r\n									<form:options  items=\"\\\\${${prop.complexEntity.lowerClassName}Map}\" cssClass=\"${p.canNull==1?\'\':\'required\'} comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n\r\n					</dd>\r\n				</dl>\r\n			</c:when>\r\n			<c:otherwise>\r\n				<p>\r\n					<label>\r\n						${p.name}：\r\n					</label>\r\n						\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}${p.dataType==2?\'digits\':\'number\'}\" />\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											cssClass=\"${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											maxlength=\"${p.length}\" />\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_${p.canNull==1?\'not_required textInput valid\':\'required textInput valid\'}\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"comboxed${p.canNull==1?\'\':\' required\'}\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${entity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\">\r\n								<option value=\"\">请选择</option>\r\n									<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}Map}\" cssClass=\"${p.canNull==1?\'\':\'required\'} comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n				</p>\r\n			</c:otherwise>\r\n		</c:choose>\r\n\r\n	</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('21', '如何在模板中嵌入JSTL和EL表达式？', '应该注意的是，模板或者标签中的JSTL或者EL表达式都是在生成源码的过程中被解析的。因此如果你需要在模板或者标签中录入需要输出结果文件中的JSTL或者EL表达式时，你需要用到转义字符。<br/>\r\n<b>$</b> 转义为：\\& 或者[_D]<br/>\r\n<b><</b> 转义为： [_LT]<br/>\r\n<b>></b> 转义为： [_GT]<br/>\r\n例如，想在结果文件中得到<fmt:formatDate/>标签，你可以写成[_LT]fmt:formatDate/>', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('22', '如何在模板中访问标签', '标签分为内置标签和自定义标签，由于JSP的特性，内置标签的使用在Java文件和Jsp文件中是不一样的，具体如下：\r\n<table collspan=\"1\" cellspacing=\"0\" border=\"1\" width=\"30%\">\r\n<tr>\r\n  <td><b>标签类型</b></td><td><b>Java</b></td><td><b>JSP</b></td>\r\n</tr>\r\n<tr>\r\n  <td>内置</td><td>$</td><td>@</td>\r\n</tr>\r\n<tr>\r\n  <td>自定义</td><td>#</td><td>#</td>\r\n</tr>\r\n\r\n</table>', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('23', '数据类型', '目前系统支持一下数据类型：<br/>\r\n<table collspan=\"1\" cellspacing=\"0\" border=\"1\" width=\"30%\">\r\n<tr>\r\n  <td><b>数据类型</b></td><td><b>值</b></td>\r\n</tr>\r\n<tr>\r\n  <td>String</td><td>1</td>\r\n</tr>\r\n<tr>\r\n  <td>Integer</td><td>2</td>\r\n</tr>\r\n<tr>\r\n  <td>Float</td><td>3</td>\r\n</tr>\r\n<tr>\r\n  <td>Date</td><td>4</td>\r\n</tr>\r\n<tr>\r\n  <td>Dictionary(暂不支持)</td><td>5</td>\r\n</tr>\r\n<tr>\r\n  <td>Complex(复杂类型)</td><td>6</td>\r\n</tr>\r\n<tr>\r\n  <td>Enum</td><td>7</td>\r\n</tr>\r\n</table>', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('24', 'UPDATE_INPUT_TRS', '修改页面Input项', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n	<c:if test=\"${p.onlyRelationship!=1}\">\r\n\r\n		<c:choose>\r\n			<c:when test=\"${p.isTotalRow==1}\">\r\n				<dl class=\\\"nowrap\\\">\r\n					<dt>\r\n						${p.name}：\r\n					</dt>\r\n					<dd>\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}${p.dataType==2?\'digits\':\'number\'}\" />\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											cssClass=\"${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											maxlength=\"${p.length}\" />\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_${p.canNull==1?\'not_required textInput valid\':\'required textInput valid\'}\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"comboxed${p.canNull==1?\'\':\' required\'}\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${entity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\">\r\n								<option value=\\\"\\\">请选择</option>\r\n									<form:options  items=\"\\\\${${prop.complexEntity.lowerClassName}Map}\" cssClass=\"${p.canNull==1?\'\':\'required\'} comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n\r\n					</dd>\r\n				</dl>\r\n			</c:when>\r\n			<c:otherwise>\r\n				<p>\r\n					<label>\r\n						${p.name}：\r\n					</label>\r\n						\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}${p.dataType==2?\'digits\':\'number\'}\" />\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											cssClass=\"${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput ${(empty p.canNull or p.canNull==0)?\'required\':\'\'}\"\r\n											maxlength=\"${p.length}\" />\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_${p.canNull==1?\'not_required textInput valid\':\'required textInput valid\'}\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"comboxed${p.canNull==1?\'\':\' required\'}\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${entity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\">\r\n								<option value=\"\">请选择</option>\r\n									<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}Map}\" cssClass=\"${p.canNull==1?\'\':\'required\'} comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n				</p>\r\n			</c:otherwise>\r\n		</c:choose>\r\n\r\n	</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('25', 'QUERY_TABLE', '列表页查询栏输入框', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n	<c:if test=\"${p.onlyRelationship!=1  and p.forQuery==1}\">\r\n\r\n		<c:choose>\r\n			<c:when test=\"${p.isTotalRow==1}\">\r\n				<dl class=\"nowrap\">\r\n					<dt>\r\n						${p.name}：\r\n					</dt>\r\n					<dd>\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput ${p.dataType==2?\'digits\':\'number\'}\" size=\"12\"/>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput\"\r\n											maxlength=\"${p.length}\"  size=\"12\"/>\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_not_required textInput valid\"  size=\"12\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"comboxed\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${entity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"  size=\"12\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\" cssClass=\"comboxed\">\r\n								<option value=\\\"\\\">请选择</option>\r\n									<form:options  items=\"\\\\${${prop.complexEntity.lowerClassName}Map}\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n\r\n					</dd>\r\n				</dl>\r\n			</c:when>\r\n			<c:otherwise>\r\n					<li>\r\n					<label>\r\n						${p.name}：\r\n					</label>\r\n					\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput${p.dataType==2?\'digits\':\'number\'}\" size=\"12\"/>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput\"\r\n											maxlength=\"${p.length}\"  size=\"12\"/>\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_not_required textInput valid\"  size=\"12\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"comboxed\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${entity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\" cssClass=\"comboxed\">\r\n								<option value=\"\">请选择</option>\r\n									<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}Map}\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n				</li>\r\n			</c:otherwise>\r\n		</c:choose>\r\n\r\n	</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('26', 'HEAD_TDS', '列表页面Table表头行', '1', '<!--<th width=\"30\" align=\"center\"><input type=\"checkbox\" group=\"${entity.idColumnName}s\" class=\"checkboxCtrl\"></th>-->\r\n<c:if test=\"${entity.idGenerateType==0}\">\r\n<th orderField=\"id\" <c:if test=\"${pageBean.orderField==\'id\'}\">class=\"${pageBean.orderDirection}\"</c:if>>编号</th>\r\n</c:if>\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.display==1}\">\r\n<th orderField=\"${p.propName}\" [_LT]c:if test=\"[_D]{pageBean.orderField==\'${p.propName}\'}\">class=\"[_D]{pageBean.orderDirection}\"[_LT]/c:if>>${p.name}</th>\r\n</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('27', 'BODY_TDS', '列表页Table行的格', '1', '<!--<td align=\"center\"><input name=\"${entity.idColumnName}s\" type=\"checkbox\" value=\"${entity.lowerClassName}.${entity.idColumnName}\"/>-->\r\n<c:set var=\"tempBeanName\" value=\"temp${entity.lowerClassName}\"/>\r\n<c:if test=\"${entity.idGenerateType==0}\">\r\n<td>[_D]{${tempBeanName}.id}</td>\r\n</c:if>\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.display==1}\">\r\n	<c:choose>\r\n		<c:when test=\"${p.dataType==6}\">\r\n			<td>[_D]{${tempBeanName}.${p.propName}<c:if test=\"${p.relationType != 2 and p.relationType != 3  and (not empty p.valuePath)}\">.${p.valuePath}</c:if>}</td>\r\n		</c:when>\r\n		<c:when test=\"${p.dataType==4}\">\r\n			<td>[_LT]fmt:formatDate value=\"[_D]{${tempBeanName}.${p.propName}}\" pattern=\"${p.timeFormat}\"/></td>\r\n		</c:when>\r\n		<c:when test=\"${p.dataType==5}\">\r\n		[暂不支持数据字典类型]\r\n		</c:when>\r\n		<c:otherwise>\r\n		<td>\r\n		<c:if test=\"${p.dataType==1}\">\r\n		[_D]{${tempBeanName}.${p.propName}}\r\n		</c:if>\r\n		<c:if test=\"${p.dataType==7}\">\r\n		[_D]{${p.complexEntity.lowerClassName}Map[${tempBeanName}.${p.propName}]}\r\n		</c:if>\r\n		</td>\r\n		</c:otherwise>\r\n	</c:choose>\r\n</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('28', '复杂类型关联关系', '<table collspan=\"1\" cellspacing=\"0\" border=\"1\" width=\"30%\">\r\n<tr>\r\n  <td><b>关系</b></td><td><b>值</b></td>\r\n</tr>\r\n<tr>\r\n  <td>一对一</td><td>1</td>\r\n</tr>\r\n<tr>\r\n  <td>多对多</td><td>2</td>\r\n</tr>\r\n<tr>\r\n  <td>一对多</td><td>3</td>\r\n</tr>\r\n<tr>\r\n  <td>多对一</td><td>4</td>\r\n</tr>\r\n\r\n</table>', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('29', '主键生成策略', '<table collspan=\"1\" cellspacing=\"0\" border=\"1\" width=\"30%\">\r\n<tr>\r\n  <td><b>生成策略</b></td><td><b>值</b></td>\r\n</tr>\r\n<tr>\r\n  <td>指定</td><td>0</td>\r\n</tr>\r\n<tr>\r\n  <td>自增长</td><td>1</td>\r\n</tr>\r\n\r\n</table>\r\n', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('30', '依据整数值判断”是否“关系', '<table collspan=\"1\" cellspacing=\"0\" border=\"1\" width=\"30%\">\r\n<tr>\r\n  <td>否</td><td>0</td>\r\n</tr>\r\n<tr>\r\n  <td>是</td><td>1</td>\r\n</tr>\r\n\r\n</table>\r\n', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('31', 'INIT_PROP_EDITOR', '初始化属性编辑器', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.dataType==6 and p.relationType==4}\">\r\n         binder.registerCustomEditor(${p.complexEntity.className}.class,new ${p.complexEntity.className}Editor(${p.complexEntity.lowerClassName}Service));\r\n</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('32', 'COMPLEX_SERVICES_DEFINE', '复杂关联关系的Service定义', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.dataType==6 and not(p.complexEntity.className eq entity.className)}\">\r\n@Resource private I${p.complexEntity.className}Service ${p.complexEntity.lowerClassName}Service;\r\n</c:if>\r\n<c:if test=\"${p.dataType==5}\">\r\n@Resource private IDictionaryDetailService dictionaryDetailService;\r\n</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('33', 'entity.idColumnName', '实体主键名称', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('34', 'entity.idColumnProp', '实体主键对应的Property，如果为空，表示为自增长类型主键', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('35', 'COMPLEX_LIST_PREPARE', '准备复杂管理关系下拉列表的集合', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.relationType!=2 and p.relationType!=3}\">\r\n<c:if test=\"${p.dataType==6}\">\r\nList<${p.dataTypeName}> ${p.complexEntity.lowerClassName}List = ${p.complexEntity.lowerClassName}Service.findAll(${p.complexEntity.className}.class);\r\nrequest.setAttribute(\"${p.complexEntity.lowerClassName}List\",${p.complexEntity.lowerClassName}List);\r\n</c:if>\r\n<c:if test=\"${p.dataType==7}\">\r\nrequest.setAttribute(\"${p.complexEntity.lowerClassName}Map\",${p.complexEntity.className}.${p.complexEntity.lowerClassName}Map);\r\n</c:if>\r\n</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('36', 'entity.name', '实体类名称，如实体Student的类名称为“学生”', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('37', 'DATATYPE_DEFAULT_VALUE_SAVE', '默认系统时间的日期类型赋值', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.dataType==4 and p.defaultSysTime==1}\">\r\n${entity.lowerClassName}.${p.setterName}(new Date());\r\n</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('38', 'property.setterName', '属性set方法名称', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('39', 'property.getterName', '属性get方法名称', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('40', 'entity.idGenerateType', '主键生成策略', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('41', 'property.dataTypeName', '属性类型名称', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('42', 'VALIDATE_ANNOTATION', '属性验证注解', '1', '<c:if test=\"${not(p.dataType==4 or p.dataType==7 or (p.dataType==6 and (p.relationType==2 or p.relationType==3)))}\">\r\n    <c:if test=\"${p.canNull==0}\">\r\n        <c:choose>\r\n            <c:when test=\"${p.dataType==1}\">\r\n                @NotBlank(message=\"${p.name}不能为空\")\r\n            </c:when>\r\n            <c:when test=\"${p.dataType==6 and (p.relationType==2 or p.relationType==3)}\">\r\n                @NotBlank(message=\"${p.name}不能为空\")\r\n            </c:when>\r\n            <c:otherwise>\r\n                @NotNull(message=\"${p.name}不能为空\")\r\n            </c:otherwise>\r\n        </c:choose>\r\n    </c:if>\r\n    <c:if test=\"${p.dataType==1} and p.length>0 and p.isTextStringType==0\">\r\n        @Length(min=0,max=${p.length},message=\"${p.name}长度不能超过${p.length}\")\r\n    </c:if>\r\n</c:if>', null);
INSERT INTO `t_varlabel` VALUES ('43', 'JPA_ANNOTATION', '生成jpa属性注解', '1', '<c:if test=\"${p.entity.type==0 and p.entity.idGenerateType==1 and p.isId==1}\">\r\n@Id\r\n@GeneratedValue(generator=\"${p.propName}_generator\")\r\n@GenericGenerator(name=\"${p.propName}_generator\",strategy=\"assigned\")\r\n</c:if>\r\n\r\n<c:if test=\"${p.dataType!=6}\">\r\n@Column(name=\"${p.columnOrPropName}\"<c:if test=\"${p.dataType==1}\">\r\n		<c:if test=\"${p.length>0}\">,length=${p.length}</c:if>\r\n<c:if test=\"${p.isTextStringType==1}\">,columnDefinition=\"text\"</c:if></c:if>,nullable=${p.canNull==1}\r\n<c:if test=\"${p.dataType==7}\">,columnDefinition=\"enum(${p.complexEntity.enumDefinitionSQL})\"</c:if>)\r\n<c:if test=\"${p.dataType==7}\">\r\n@Enumerated(EnumType.STRING)\r\n</c:if>\r\n</c:if>\r\n\r\n<c:if test=\"${p.dataType==6}\">\r\n<c:choose>\r\n   <c:when test=\"${p.relationType==3}\">\r\n@OneToMany(targetEntity=${p.complexEntity.fullClassName}.class,mappedBy=\"${p.setKeyCoumn}\",fetch=FetchType.LAZY)\r\n   </c:when>\r\n   <c:when test=\"${p.relationType==4}\">\r\n@ManyToOne(targetEntity=${p.complexEntity.fullClassName}.class,fetch=FetchType.LAZY)\r\n@JoinColumn(name=\"${p.columnOrPropName}\",nullable=${p.canNull==1})\r\n@Fetch(FetchMode.SELECT)\r\n   </c:when>\r\n   <c:when test=\"${p.relationType==1}\">\r\n      \r\n   </c:when>\r\n   <c:when test=\"${p.relationType==2}\">\r\n@ManyToMany(targetEntity=${p.complexEntity.fullClassName}.class)\r\n@JoinTable(name=\"${p.middletable}\",joinColumns={@JoinColumn(name=\"${p.entity.idColumnNameForForeignUse}\")},inverseJoinColumns={@JoinColumn(name=\"${p.complexEntity.idColumnNameForForeignUse}\")})\r\n   </c:when>\r\n</c:choose>\r\n</c:if>', null);
INSERT INTO `t_varlabel` VALUES ('44', 'NOW', '系统当前时间', '0', 'x', null);
INSERT INTO `t_varlabel` VALUES ('45', 'ADD_CAUSE_ON_CRITERIA', '根据查询参数设置Criteria', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.forQuery==1 and p.relationType!=2 and p.relationType!=3}\">\r\n\r\n<c:set var=\"propAccessName\" value=\"${entity.lowerClassName}.${p.getterName}()\"/>\r\n<c:choose>\r\n    <c:when test=\"${p.dataType==5 or dataType==6}\">  \r\n        if(${propAccessName}!=null && ${propAccessName}.${p.complexEntity.idColumnGetterName}() != null){\r\n            criteria.add(Restrictions.eq(\"${p.propName}.${p.complexEntity.idColumnName}\",${propAccessName}.${p.complexEntity.idColumnGetterName}()));\r\n        }\r\n    </c:when>\r\n    <c:when test=\"${p.dataType==4 or dataType==3 or dataType==2}\">\r\nif(${entity.lowerClassName}.${p.getterName}Start()!=null){\r\ncriteria.add(Restrictions.ge(\"${p.propName}\",${entity.lowerClassName}.${p.getterName}Start()));\r\n}\r\nif(${entity.lowerClassName}.${p.getterName}End()!=null){\r\ncriteria.add(Restrictions.ge(\"${p.propName}\",${entity.lowerClassName}.${p.getterName}End()));\r\n}\r\n    </c:when>\r\n    <c:otherwise>\r\n       if(${p.entity.lowerClassName}.${p.getterName}()!=null\r\n<c:if test=\"${p.dataType==1}\"> && ! ${p.entity.lowerClassName}.${p.getterName}().trim().equals(\"\")</c:if>){\r\n		criteria.add(Restrictions.${p.dataType==1?\'like\':\'eq\'}(\"${p.propName}\",${entity.lowerClassName}.${p.getterName}()${p.dataType==1?\',MatchMode.ANYWHERE\':\'\'}));\r\n}\r\n    </c:otherwise>\r\n</c:choose>\r\n\r\n</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('46', 'entityIteratorIndex', '遍历各个实体时的序号，从1开始。从这个值可以知道当前的实体代码生成时处于整个实体集合的什么位置，最常用在sql文件的生成。', '0', '', null);
INSERT INTO `t_varlabel` VALUES ('47', 'SHJqueryUI_ADD_INPUT_TRS', 'JQueryUI：增加页面字段行', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n	<c:if test=\"${p.onlyRelationship!=1}\">\r\n		<c:choose>\r\n			<c:when test=\"${p.isTotalRow==1}\">\r\n				<tr>\r\n					<td align=\"right\">\r\n						${p.name}：\r\n					</td>\r\n					<td>\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"InputStyle\" vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'},custom[${p.dataType==2?\'integer\':\'number\'}]<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"/>\r\n									<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n											cssClass=\"TextareaStyle\"/>\r\n										<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n											cssClass=\"InputStyle\"/>\r\n										<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_${p.canNull==1?\'not_required textInput valid\':\'required textInput valid\'}\"/>\r\n								<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"SelectStyle\" vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\"/>\r\n								</form:select>\r\n								<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\" cssClass=\"SelectStyle\" vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\">\r\n								<option value=\"\">请选择</option>\r\n									<form:options  items=\"\\\\${${prop.complexEntity.lowerClassName}Map}\"/>\r\n								</form:select>\r\n								<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n						</c:choose>\r\n					</td>\r\n				</tr>\r\n			</c:when>\r\n			<c:otherwise>\r\n				<tr>\r\n					<td align=\"right\">\r\n						${p.name}：\r\n					</td>\r\n					<td>\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"InputStyle\" vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'},custom[${p.dataType==2?\'integer\':\'number\'}]<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"/>\r\n								<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											cssClass=\"TextareaStyle\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n										 />\r\n										<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"InputStyle\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n										 />\r\n										<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date\"\r\n									   vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\"\r\n									   />\r\n								<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"SelectStyle\" vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\">\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\"/>\r\n								</form:select>\r\n								<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\" cssClass=\"SelectStyle\" vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\">\r\n								<option value=\"\">请选择</option>\r\n									<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}Map}\"/>\r\n								</form:select>\r\n								<c:if test=\"${empty p.canNull or p.canNull==0}\">?<font style=\"color:red\">*</font></c:if>\r\n							</c:when>\r\n						</c:choose>\r\n					</td>\r\n				</tr>\r\n			</c:otherwise>\r\n		</c:choose>\r\n	</c:if>\r\n</c:forEach>', '15');
INSERT INTO `t_varlabel` VALUES ('48', 'SHJqueryUI_UPDATE_INPUT_TRS', '', '1', '<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n	<c:if test=\"${p.onlyRelationship!=1}\">\r\n		<c:choose>\r\n			<c:when test=\"${p.isTotalRow==1}\">\r\n				<tr>\r\n					<td align=\"right\">\r\n						${p.name}：\r\n					</td>\r\n					<td>\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"InputStyle\" \r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'},custom[${p.dataType==2?\'integer\':\'number\'}]<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n								/>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											cssClass=\"TextareaStyle\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n											maxlength=\"${p.length}\" />\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date\"\r\n									   vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\"\r\n									   />\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"SelectStyle\"\r\n								vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\"			 \r\n								>\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" cssClass=\"SelectStyle\" path=\"${p.propName}\"\r\n								vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\"			 \r\n								>\r\n								<option value=\"\">请选择</option>\r\n									<form:options  items=\"\\\\${${prop.complexEntity.lowerClassName}Map}\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n						<c:if test=\"${empty p.canNull or p.canNull==0}\"> <font style=\"color:red\">*</font></c:if>\r\n					</td>\r\n				</tr>\r\n			</c:when>\r\n			<c:otherwise>\r\n				<tr>\r\n					<td align=\"right\">\r\n						${p.name}：\r\n					</td>\r\n					<td>	\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"InputStyle\" \r\n									vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'},custom[${p.dataType==2?\'integer\':\'number\'}]<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n									/>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											cssClass=\"TextareaStyle\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"InputStyle\"\r\n											vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}<c:if test=\"${p.isTextStringType==0}\">,maxSize[${p.length}]</c:if>]\"\r\n											maxlength=\"${p.length}\" />\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date\"\r\n								vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\"	   \r\n								/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"SelectStyle\"\r\n								vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\"			 \r\n								>\r\n								<option value=\"\">请选择</option>\r\n								<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" cssClass=\"SelectStyle\" path=\"${p.propName}\"\r\n								vl=\"validate[${(empty p.canNull or p.canNull==0)?\'required\':\'optional\'}]\"\r\n								>\r\n								<option value=\"\">请选择</option>\r\n									<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}Map}\" cssClass=\"${p.canNull==1?\'\':\'required\'} comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n					<c:if test=\"${empty p.canNull or p.canNull==0}\"> <font style=\"color:red\">*</font></c:if>\r\n					</td>\r\n				</tr>\r\n			</c:otherwise>\r\n		</c:choose>\r\n	</c:if>\r\n</c:forEach>', '15');
INSERT INTO `t_varlabel` VALUES ('49', 'SHJqueryUI_Query_Table', '查询表单', '1', '<c:set var=\"row_count\" value=\"0\"/>\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n	<c:if test=\"${p.onlyRelationship!=1  and p.forQuery==1}\">\r\n		<c:choose>\r\n			<c:when test=\"${p.isTotalRow==1}\">\r\n				<tr>\r\n					<td>\r\n						${p.name}：\r\n					</td>\r\n					<td colspan=\"3\">\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput ${p.dataType==2?\'digits\':\'number\'}\" size=\"12\"/>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput\"\r\n											maxlength=\"${p.length}\"  size=\"12\"/>\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_not_required textInput valid\"  size=\"12\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"SelectStyle comboxed\">\r\n								<option value=\"\">-全部-</option>\r\n								<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"  size=\"12\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\" cssClass=\"SelectStyle comboxed\">\r\n								<option value=\\\"\\\">-全部-</option>\r\n									<form:options  items=\"\\\\${${prop.complexEntity.lowerClassName}Map}\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n\r\n					</td>\r\n				</tr>\r\n			</c:when>\r\n			<c:otherwise>\r\n				<c:set var=\"row_count\" value=\"${row_count+1}\"/>\r\n				<c:if test=\"${not((row_count mod 2) eq 0)}\">\r\n					<tr>\r\n				</c:if>\r\n				\r\n					<td>\r\n						${p.name}：\r\n					</td>\r\n					<td>\r\n						<c:choose>\r\n							<c:when test=\"${p.dataType==2 or p.dataType==3}\">\r\n								<form:input path=\"${p.propName}\"\r\n									id=\"${entity.lowerClassName}.${p.propName}\" type=\"text\"\r\n									cssClass=\"textInput${p.dataType==2?\'digits\':\'number\'}\" size=\"12\"/>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==1}\">\r\n								<c:choose>\r\n									<c:when test=\"${p.isTextArea==1}\">\r\n										<form:textarea path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\" cols=\"${p.col}\"\r\n											rows=\"${p.row}\"\r\n											<c:if test=\"${p.isTextStringType==0}\">maxlength=\"${p.length}\"</c:if> />\r\n									</c:when>\r\n									<c:otherwise>\r\n										<form:input path=\"${p.propName}\"\r\n											id=\"${entity.lowerClassName}.${p.propName}\"\r\n											cssClass=\"textInput\"\r\n											maxlength=\"${p.length}\"  size=\"12\"/>\r\n									</c:otherwise>\r\n								</c:choose>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==4}\">\r\n								<input name=\"${p.name}\" id=\"${entity.lowerClassName}.${p.propName}\" onclick=\"WdatePicker({dateFmt:\'\\\\${applicationScope.YYYY_MM_DD}\'});\"\r\n								value=\"[_LT]fmt:formatDate pattern=\'\\\\${applicationScope.YYYY_MM_DD}\' value=\'\\\\${${entity.lowerClassName}.${p.propName}}\'/>\" class=\"date_not_required textInput valid\"  size=\"12\"/>\r\n							</c:when>\r\n							\r\n							<c:when test=\"${p.dataType==6}\">\r\n								<form:select id=\"${p.propName}\" path=\"${p.propName}\" cssClass=\"SelectStyle comboxed\">\r\n								<option value=\"\">-全部-</option>\r\n								<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}List}\" itemValue=\"${p.complexEntity.idColumnName}\" itemLabel=\"${p.valuePath}\" cssClass=\"comboxed\"/>\r\n								</form:select>\r\n							</c:when>\r\n							<c:when test=\"${p.dataType==7}\">\r\n								<form:select id=\"${p.propName}.${p.complexEntity.idColumnName}\" path=\"${p.propName}\" cssClass=\"SelectStyle comboxed\">\r\n								<option value=\"\">-全部-</option>\r\n									<form:options  items=\"\\\\${${p.complexEntity.lowerClassName}Map}\"/>\r\n								</form:select>\r\n							</c:when>\r\n						</c:choose>\r\n					<td>\r\n						<c:if test=\"${(row_count mod 2) eq 0}\">\r\n				</tr>\r\n				</c:if>\r\n			</c:otherwise>\r\n		</c:choose>\r\n\r\n	</c:if>\r\n</c:forEach>', null);
INSERT INTO `t_varlabel` VALUES ('50', 'SHJqueryUI_HEAD_TDS', '列表表头', '1', '<!--<th width=\"30\" align=\"center\"><input type=\"checkbox\" group=\"${entity.idColumnName}s\" class=\"checkboxCtrl\"></th>-->\r\n<c:if test=\"${entity.idGenerateType==0}\">\r\n<th orderField=\"id\" <c:if test=\"${pageBean.orderField==\'id\'}\">class=\"${pageBean.orderDirection}\"</c:if>>编号</th>\r\n</c:if>\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.display==1}\">\r\n<th orderField=\"${p.propName}\" [_LT]c:if test=\"[_D]{pageBean.orderField==\'${p.propName}\'}\">class=\"[_D]{pageBean.orderDirection}\"[_LT]/c:if>>${p.name}</th>\r\n</c:if>\r\n</c:forEach>\r\n<th>\r\n操作\r\n</th>', '15');
INSERT INTO `t_varlabel` VALUES ('51', 'SHJqueryUI_Body_TDS', '列表表格TD', '1', '<!--<td align=\"center\"><input name=\"${entity.idColumnName}s\" type=\"checkbox\" value=\"${entity.lowerClassName}.${entity.idColumnName}\"/>-->\r\n<c:set var=\"tempBeanName\" value=\"temp${entity.lowerClassName}\"/>\r\n<c:if test=\"${entity.idGenerateType==0}\">\r\n<td>[_D]{${tempBeanName}.id}</td>\r\n</c:if>\r\n<c:forEach items=\"${entity.properties}\" var=\"p\">\r\n<c:if test=\"${p.display==1}\">\r\n	<c:choose>\r\n		<c:when test=\"${p.dataType==6}\">\r\n			<td>[_D]{${tempBeanName}.${p.propName}<c:if test=\"${p.relationType != 2 and p.relationType != 3  and (not empty p.valuePath)}\">.${p.valuePath}</c:if>}</td>\r\n		</c:when>\r\n		<c:when test=\"${p.dataType==4}\">\r\n			<td>[_LT]fmt:formatDate value=\"[_D]{${tempBeanName}.${p.propName}}\" pattern=\"${p.timeFormat}\"/></td>\r\n		</c:when>\r\n		<c:when test=\"${p.dataType==5}\">\r\n		[暂不支持数据字典类型]\r\n		</c:when>\r\n		<c:otherwise>\r\n		<td>\r\n		<c:if test=\"${p.dataType==1}\">\r\n		[_D]{${tempBeanName}.${p.propName}}\r\n		</c:if>\r\n		<c:if test=\"${p.dataType==7}\">\r\n		[_D]{${p.complexEntity.lowerClassName}Map[${tempBeanName}.${p.propName}]}\r\n		</c:if>\r\n		</td>\r\n		</c:otherwise>\r\n	</c:choose>\r\n</c:if>\r\n</c:forEach>\r\n<td>\r\n	[_LT]n:pv url=\"${entity.lowerClassName}/update.do\"[_GT]\r\n	<a class=\"edit\" href=\"[_D]{basePath}${entity.lowerClassName}/update.do?${entity.idColumnName}=[_D]{temp${entity.lowerClassName}.id}\"><span>修改</span></a>\r\n	[_LT]/n:pv[_GT]\r\n	[_LT]n:pv url=\"${entity.lowerClassName}/delete.do\"[_GT]\r\n<a class=\"delete\" href=\"[_D]{basePath}${entity.lowerClassName}/delete.do?${entity.idColumnName}=[_D]{temp${entity.lowerClassName}.id}\" onclick=\"return window.confirm(\'确认要删除该记录吗?\');\"><span>删除</span></a>\r\n	[_LT]/n:pv[_GT]\r\n</td>', null);

-- ----------------------------
-- Table structure for `t_versionrecord`
-- ----------------------------
DROP TABLE IF EXISTS `t_versionrecord`;
CREATE TABLE `t_versionrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `addTime` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_versionrecord
-- ----------------------------
INSERT INTO `t_versionrecord` VALUES ('1', '1.0', '2013-01-01 16:44:29', '<b>1.</b>hibernate映射文件生成<br/>\r\n<b>2.</b>Action、Service、ServiceImpl代码生成<br/>\r\n<b>3.</b>增删改查JSP页面生成<br/>\r\n<b>4.</b>支持多种数据类型：数字、字符串、日期、数据字典、复杂类型<br/>\r\n<b>5.</b>导入导出');
INSERT INTO `t_versionrecord` VALUES ('2', '1.1', '2013-01-09 16:47:36', '<b>1.</b>增加枚举类型<br/>\r\n<b>2.</b>优化批量导入');
INSERT INTO `t_versionrecord` VALUES ('3', '1.5', '2013-08-21 10:56:01', '基于JSP引擎，将模板和程序分离；<br/>\r\n新增模板组和模板管理；<br/>\r\n新增映射管理，实现需要生成哪些文件、生成到什么动态管理功能；<br/>\r\n新增标签管理，增加模板代码复用性；<br/>\r\n\r\n');
INSERT INTO `t_versionrecord` VALUES ('4', '1.6', '2013-08-30 10:57:55', '新增生成结果代码预览功能；<br/>\r\n新增模板在线编辑功能,元素自动补齐，标签提示；<br/>');
INSERT INTO `t_versionrecord` VALUES ('5', '1.7', '2013-09-06 10:59:25', '支持简单工作流；<br/>\r\nSQL文件生成；<br/>\r\n项目上下文建设；');
