%%%% Experts System %%%
:- dynamic(room/4).
:- dynamic(course/4).
:- dynamic(occupe/3).
:- dynamic(instructor/3).
:- dynamic(student/2).
% room(id, capacity, hours(opening_time, closing_time), [projector, board, disabled_accessible]).
% course(id, instructor, capacity, [projector, board, disabled_accessible]).
% occupe(room, course_name, weektime(start_time, end_time, weekday)).
% instructor(identity(id, name, disability), [courses], [projector, board, disabled_accessible]).
% student(identity(id, name, disability), [courses]).

%
%%% Knowledge Base %%%
%
% Room
room(z23, 120, hours( 8, 17), [projector, board]).
room(z06,  40, hours(10, 18), [projector, disabled_accessible]).
room(z10,  60, hours( 8, 17), [projector, board, disabled_accessible]).

% Course
course(eng151, gokturk, 120, [projector]).
course(cse241, akgul,    90, [projector]).
course(cse341, genc,    480, [projector]).
course(cse343, kalkan,   90, [projector]).

% Occupance
occupe(z23, eng151, weektime( 8, 10, mon)).
occupe(z23, cse341, weektime(11, 13, mon)).
occupe(z23, cse343, weektime(14, 16, mon)).
occupe(z23, cse341, weektime(13, 15, wed)).
occupe(z23, cse343, weektime(11, 13, thu)).
occupe(z23, eng151, weektime(14, 16, thu)).
occupe(z23, cse241, weektime(11, 13, fri)).

occupe(z06, eng151, weektime(10, 12, mon)).
occupe(z06, cse343, weektime(14, 16, mon)).
occupe(z06, cse341, weektime(10, 12, wed)).
occupe(z06, eng151, weektime( 8, 10, thu)).
occupe(z06, cse241, weektime( 8, 10, fri)).
occupe(z06, cse341, weektime(14, 16, fri)).

occupe(z10, cse241, weektime( 8, 10, mon)).
occupe(z10, cse343, weektime(13, 16, thu)).
occupe(z10, cse341, weektime( 8, 10, thu)).
occupe(z10, cse343, weektime(11, 13, thu)).
occupe(z10, cse241, weektime(14, 16, fri)).
occupe(z10, eng151, weektime(11, 13, fri)).

% Instructor
instructor(identity(1, gokturk, false), [eng151], [projector]).
instructor(identity(2, akgul,   false), [cse241], [projector]).
instructor(identity(3, genc,    false), [cse341], [projector, board]).
instructor(identity(4, kalkan,  false), [cse343], [projector]).
instructor(identity(5, ilhan,   false), [cse485], [projector]).

% Student
student(identity(1, ali,     false), [eng151, cse241, cse341, cse343]).
student(identity(2, veli,    false), [eng151, cse341]).
student(identity(3, ayse,     true), [eng151, cse341, cse343]).
student(identity(4, fatma,   false), [cse241, cse341]).
student(identity(5, ahmet,   false), [cse241, cse343]).
student(identity(6, mehmet,  false), [eng151, cse341, cse343]).
student(identity(7, zeynep,   true), [cse241, cse343]).
student(identity(8, hasan,   false), [eng151, cse341]).
student(identity(9, huseyin, false), [cse241, cse341]).

%
%%% Rules %%%
%
%%% Queries: check_room_conflicts, get_assigned_room, get_possible_room_class_pairs, 
% can_student_enroll, get_possible_enrollments, add_student, add_course, add_room, add_occupation


main :- 
    write('Expert System'), nl.