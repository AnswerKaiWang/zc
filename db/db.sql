-- 2016-08-23
ALTER TABLE user_second ADD COLUMN user_risk_level_id INT(20) NULL COMMENT '用户风险评级';
ALTER TABLE user_second ADD COLUMN user_evaluate_time VARCHAR(10) NULL COMMENT '评测时间';
ALTER TABLE user_second_per ADD COLUMN per_zip VARCHAR(255) NULL COMMENT '邮编';
ALTER TABLE user_second_com ADD COLUMN com_tel VARCHAR(20) NULL COMMENT '固话';
ALTER TABLE user_second_com ADD COLUMN com_email VARCHAR(255) NULL COMMENT '邮件';