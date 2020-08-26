CREATE TABLE bouy (
  num int(11) NOT NULL AUTO_INCREMENT,
  obs_post_id char(7) NOT NULL,
  obs_post_name varchar(30) NOT NULL,
  obs_lat varchar(10) NOT NULL,
  obs_lon varchar(10) NOT NULL,
  obs_last_req_cnt varchar(11) NOT NULL,
  record_time varchar(19) NOT NULL,
  water_temp varchar(10) NOT NULL,
  salinity varchar(10) NOT NULL,
  air_temp varchar(10) NOT NULL,
  air_pres varchar(10) NOT NULL,     
  wind_dir varchar(10) NOT NULL,
  wind_speed varchar(10) NOT NULL,
  current_dir varchar(10) NOT NULL,
  current_speed varchar(10) NOT NULL,
  wave_height varchar(10) NOT NULL,
  posted datetime DEFAULT NOW(),
  primary key (num)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

DELIMITER //
CREATE PROCEDURE AveragemeasuredValue(
  IN year VARCHAR(255),
  IN month VARCHAR(255)
)
BEGIN
  select
    obs_post_name as area, substr(record_time,1,4) as year, substr(record_time,6,2) as month,
    round(avg(replace(water_temp,'None',0)),1) as water_temp,
    round(avg(replace(salinity,'None',0)),1) as salinity, 
    round(avg(replace(air_temp,'None',0)),1) as air_temp, 
    round(avg(replace(air_pres,'None',0)),1) as air_pres, 
    round(avg(replace(wind_dir,'None',0)),1) as wind_dir, 
  round(avg(replace(wind_speed,'None',0)),1) as wind_speed, 
  round(avg(replace(current_dir,'None',0)),1) as current_dir, 
  round(avg(replace(current_speed,'None',0)),1) as current_speed, 
  round(avg(replace(wave_height,'None',0)),1) as wave_height from bouy 
  where substr(record_time,1,4) = year
  and substr(record_time,6,2) = month group by obs_post_name;
END //
DELIMITER ;

call AveragemeasuredValue('2020','08')