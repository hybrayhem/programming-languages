%%%% Experts System: room{}, course{}, student{}, instructor{}.

% Room: id, capacity, opening_time, closing_time, occupants[], properties[projector, 
% smart_board, disabled-accessibility, ...]
%       occupant: start_time, end_time, course_name

% Course: id, instructor, capacity, occupances[], requirements[projector, ...] 
%       occupance: start_time, end_time, room

% identity: id, name, disability
% Instructor: identity, courses, requirements[projector, ...]
% Student: identity, courses

%%% Queries: check_room_conflicts, get_assigned_room, get_possible_room_class_pairs, 
% can_student_enroll, get_possible_enrollments, add_student, add_course, add_room


main :- 
    write('Expert System'), nl.