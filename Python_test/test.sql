-- Student(stuId,stuName,stuAge,stuSex) 学生表
-- stuId：学号；stuName：学生姓名；stuAge：学生年龄；stuSex：学生性别
--
-- Course(courseId,courseName,teacherId) 课程表
-- courseId,课程编号；courseName：课程名字；teacherId：教师编号
--
-- Scores(stuId,courseId,score) 成绩表
-- stuId：学号；courseId,课程编号；score：成绩
--
-- Teacher(teacherId,teacherName) 教师表
-- teacherId：教师编号； teacherName：教师名字
-- 问题：
-- 1、	查询“001”课程比“002”课程成绩高的所有学生的学号；
-- 2、	查询平均成绩大于60分的同学的学号和平均成绩；
-- 3、	查询所有同学的学号、姓名、选课数、总成绩；
-- 4、查询姓“李”的老师的个数；
-- 5、查询没学过“叶平”老师课的同学的学号、姓名；
;
select t1.stuId
from (SELECT stuId, score
      from Scores
      where courseId = '001') t1
         left join
     (SELECT stuId, score
      from Scores
      where courseId = '001') t2 on t1.stuId = t2.stuId
where t1.score > t2.score;

select stuId, avg_sorce
from (SELECT stuId, avg(score) avg_sorce
      from Scores
      group by 1) t1
where avg_sorce > 60;

select t1.stuId, t1.stuName, course_num, total_sorce
from Student t1
         left join
     (SELECT stuId,
             sum(score)      total_sorce,
             count(courseId) course_num
      from Scores
      group by 1) t2 on t1.stuId = t2.stuId
;

select count(teacherId)
from Teacher
where teacherName like '李%';

select q1.stuId, q1.stuName
from Student q1
-- 学过叶平老师的所有人-去重
         (select t1.stuId
from Scores t1
         left join t2 on t1.courseId = t2.courseId
         left join Teacher t3 on t2.teacherId = t3.teacherId
where t3.teacherName='叶平'
group by 1) q2
on q1.stuId = q2.stuId
where q2.stuId is null
group by 1, 2
;

