%%%% Experts System %%%
:- dynamic(room/4).
:- dynamic(course/4).
:- dynamic(occupe/3).
:- dynamic(instructor/5).
:- dynamic(student/4).

%
%%% Knowledge Base %%%
%
% Room
room(z23,    120, hours( 8, 17), [projector, board]).
room(z06,     60, hours(10, 18), [projector, disabled_accessible]).
room(z10,     90, hours( 8, 17), [projector, board, disabled_accessible]).
room(online, 500, hours(_, _), [projector, board, disabled_accessible]).

% Course
course(eng151, gokturk, 120, [projector]).
course(cse241, akgul,    90, [projector]).
course(cse341, genc,    480, [projector]).
course(cse343, kalkan,   90, [projector]).
% course(cse485, ilhan,    50, [board]).

% Occupance
occupe(_, _, weektime(12, 13, _)). % Lunch time
occupe(_, _, weektime(_, _, sat)). % Weekend
occupe(_, _, weektime(_, _, sun)).

occupe(online, eng151, weektime( 11, 13, mon)).
occupe(z10,    eng343, weektime( 14, 17, mon)).

occupe(z06,    cse241, weektime( 10, 12, tue)).
occupe(z10,    cse341, weektime( 14, 16, tue)).

occupe(z06,    cse241, weektime( 10, 11, wed)).
occupe(z23,    cse341, weektime( 14, 16, wed)).

occupe(z23,    cse241, weektime( 10, 12, thu)).


% Instructor
instructor(1, gokturk, false, [eng151], [projector]). % TODO: course list, equipments are unnecessary
instructor(2, akgul,   false, [cse241], [projector]).
instructor(3, genc,    false, [cse341], [projector, board]).
instructor(4, kalkan,  false, [cse343], [projector]).
% instructor(identity(5, ilhan,   false), [cse485], [board]).

% Student
student(1, ali,     false, [eng151, cse241, cse341, cse343]).
student(2, veli,    false, [eng151, cse341]).
student(3, ayse,     true, [eng151, cse341, cse343]).
student(4, fatma,   false, [cse241, cse341]).
student(5, ahmet,   false, [cse241, cse343]).
student(6, mehmet,  false, [eng151, cse341, cse343]).
student(7, zeynep,   true, [cse241, cse343]).
student(8, hasan,   false, [eng151, cse341]).
student(9, huseyin, false, [cse241, cse341]).

%
%%% Rules %%%
%

% Check whether there is any scheduling conflict
check_room_conflicts :-
    occupe(Room1, Course1, weektime(Start1, End1, Day1)),
    occupe(Room2, Course2, weektime(Start2, End2, Day2)),
    Room1 = Room2,
    Day1 = Day2,
    (Start1 >= Start2, Start1 =< End2) | (End1 >= Start2, End1 =< End2),
    format('Room ~w and ~w are occupied at the same time!~n', [Room1, Room2]),
    fail.

% Check which room can be assigned to a given class.
get_available_room(Course, weektime(Start, End, Day)) :-
    course(Course, _, CourseCapacity, CourseEquipments),
    room(Room, RoomCapacity, _, RoomEquipments),
    % Check capacity and equipments of the room and the course are compatible
    CourseCapacity =< RoomCapacity,
    subset(CourseEquipments, RoomEquipments),
    \+ occupe(Room, _, weektime(Start, End, Day)),
    format('Room ~w can be assigned to ~w~n', [Room, Course]),
    fail.

% Check which room can be assigned to which classes.
get_available_rooms :-
    course(Course, _, _, _),
    get_available_room(Course, weektime(Start, End, Day)),
    fail.

% Check whether a student can be enrolled to a given class
check_enrollment(Student, Course) :-
    student(Student, _, StudentDisability, StudentCourses),
    course(Course, _, _, CourseEquipments),
    % Check if the student is disabled and the class is disabled accessible or not
    StudentDisability = false
    | 
    (StudentDisability = true, member(disabled_accessible, CourseEquipments)),
    % Check if the student is already enrolled to the class
    \+ member(Course, StudentCourses),
    format('Student ~w can be enrolled to ~w~n', [Student, Course]),
    fail.

% Check which classes a student can be assigned.
get_available_courses(Student) :-
    student(Student, _, _, _),
    course(Course, _, _, _),
    check_enrollment(Student, Course),
    fail.

% Student
print_students :- 
    student(ID, Name, Disability, Courses), 
    format('~w ~w ~w ~w~n', [ID, Name, Disability, Courses]), 
    fail.

add_student(ID, Name, Disability) :- 
    student(ID, _, _, _), 
    !, 
    write('Student already exists!'). % ! for cut, to prevent backtracking

add_student(ID, Name, Disability) :- 
    assert(student(ID, Name, Disability, [])), 
    write('Student added!').

enroll_student(StudentID, Course) :-
    student(StudentID, Name, Disability, StudentCourses),
    course(Course, _, _, _),
    check_enrollment(StudentID, Course),
    retract(student(StudentID, _, _, _)),
    assert(student(StudentID, Name, Disability, [Course|StudentCourses])),
    write('Student enrolled!').

remove_student(ID) :- 
    retract(student(ID, _, _, _)), 
    write('Student removed!').

% Course
print_courses :- 
    course(ID, Instructor, Capacity, Equipments), 
    format('~w ~w ~w ~w~n', [ID, Instructor, Capacity, Equipments]), 
    fail.

add_course(ID, Instructor, Capacity, Equipments) :-
    course(ID, _, _, _), !, 
    write('Course already exists!').

add_course(ID, Instructor, Capacity, Equipments) :-
    assert(course(ID, Instructor, Capacity, Equipments)), 
    write('Course added!').

remove_course(ID) :-
    retract(course(ID, _, _, _)), 
    write('Course removed!').


% Room
print_rooms :-
    room(ID, Capacity, Hours, Equipments), 
    format('~w ~w ~w ~w~n', [ID, Capacity, Hours, Equipments]), 
    fail.

add_room(ID, Capacity, Hours, Equipments) :-
    room(ID, _, _, _), 
    !, 
    write('Room already exists!').

add_room(ID, Capacity, Hours, Equipments) :-
    assert(room(ID, Capacity, Hours, Equipments)), 
    write('Room added!').

remove_room(ID) :-
    retract(room(ID, _, _, _)), 
    write('Room removed!').


% Occupation
print_occupations :-
    occupe(Room, Course, Weektime), 
    format('~w ~w ~w~n', [Room, Course, Weektime]), 
    fail.

occupy_room(Room, Course, weektime(Start, End, Day)) :-
    occupe(Room, Course, weektime(X, Y, Day)),
    (X >= Start, X =< End) | (Y >= Start, Y =< End),
    !,
    write('Room is already occupied!'),
    fail.

occupy_room(Room, Course, Weektime) :-
    assert(occupe(Room, Course, Weektime)), 
    write('Room occupied!').

remove_occupation(Room, Course, Weektime) :-
    retract(occupe(Room, Course, Weektime)), 
    write('Occupation removed!').

%
%%% Main %%%
%
main :- 
    write('Expert System'), nl,
    print_courses | true, nl, 
    print_rooms | true, nl, 
    print_students | true , nl.