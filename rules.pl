
% rules

append2( [], L, L).
append2( [H|T], L2, [H|NT]):-
	append2(T, L2, NT).


member2(E,[E|_]).
member2(E,[_|T]):-
member2(E,T).

passed(Stud,Course):-
student(Stud,Course,G),
   (  G > 50
       -> true ,!
       ;  false,!
    ).
%1
studentsInCourse(F,Students):-
studentsInCourse(F,[],Students).

studentsInCourse(F,Templist,Students):-
student(X,F,Y),
\+(member2([X,Y],Templist)),
append2([[X,Y]],Templist,Newlist),
studentsInCourse(F,Newlist,Students),!.

studentsInCourse(_,Students,Students).


%2
len([],0).
len([_|T],R):-
len(T,R1),
R is 1+R1.



numStudents(F, Num):-
studentsInCourse(F,[],Students),
len(Students,Num).



%3
studentG(A,Templist,Grades):-
student(A,_,B),
\+(member2(B,Templist)),!,
append2([B],Templist,Newlist),
studentG(A,Newlist,Grades).

studentG(_,Grades,Grades).

getMax([M|T],Max):-
getMax(T,M,Max).

getMax([],M,M).
getMax([H|T],M,Max):-
H>M
->
getMax(T,H,Max)
;
getMax(T,M,Max).

maxStudentGrade(P, MaxGrade):-
studentG(P,[],Grades),
getMax(Grades,MaxGrade).

%4
numInWord(0,zero).
numInWord(1,one).
numInWord(2,two).
numInWord(3,three).
numInWord(4,four).
numInWord(5,five).
numInWord(6,six).
numInWord(7,seven).
numInWord(8,eight).
numInWord(9,nine).




gradeInWords(S,O,DigitsWords):-
student(S,O,N),

   N =:= 100
-> DigitsWords = ['one','zero','zero']
;
student(S,O,N),
 A is N mod(10),
numInWord(A,R1),
B is floor(N/10),
   B =:= 0
->DigitsWords =[R1]
;
 student(S,O,N),
 A is N mod(10),
numInWord(A,R1),
B is floor(N/10),
numInWord(B,R2),
DigitsWords =[R2,R1],!.

%5
courses(S,C,Courses):-
courses(S,C,[],Courses).
courses(S,C,List,Courses):-
prerequisite(Y,C),
\+(member2([Y],List)), \+(passed(S,Y)),
append2([Y],List,Newlist),
courses(S,Y,Newlist,Courses),!.

courses(_,_,Courses,Courses).


head([H|_], H).

check(S,C):-

( courses(S,C,[],Courses),
%write(Courses),
  head(Courses,R),
  % write(R),

  prerequisite(Y,R),
 %  write(Y),

  student(S,Y,_),passed(S,Y))

  ;
 (    courses(S,C,[],Courses),
 % write(Courses),
     len(Courses,M),
   %  write(M),
     M =:= 0)
  .





remainingCourses(S,C, Courses):-
	check(S,C),
	courses(S,C, Courses),!.



