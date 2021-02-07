--write the SQL to determine which students have completed at least 4 '500 - level' classes with a grade of 3.6 or greater
-- that have also completed 18 credits in buildings located on West Campus.


SELECT S.StudentID, S.StudentFname, S.StudentLname
FROM tblSTUDENT AS S
    JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
    JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
    JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
    JOIN ( 
        SELECT S.StudentID, S.StudentFname, S.StudentLname
        FROM tblSTUDENT S
            JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
            JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
            JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
            JOIN tblCLASSROOM CM ON CS.ClassroomID = CM.ClassroomID
            JOIN tblBUILDING B ON CM.BuildingID = B.BuildingID
            JOIN tblLOCATION L ON B.LocationID = L.LocationID
        WHERE L.LocationName = 'West Campus'
        GROUP BY S.StudentID, S.StudentFname, S.StudentLname
        HAVING SUM(CR.Credits) = 18
    ) AS subqry1 On S.StudentID = subqry1.StudentID
WHERE CL.Grade >= 3.6 AND CR.CourseName LIKE '%5__'
GROUP BY S.StudentID, S.StudentFname, S.StudentLname
HAVING COUNT(CR.CourseName) >= 4

