# IS-420-Database-Application-Development-Spring-2025
You will be assigned into groups of four to five people in this project. Please read the whole document carefully before starting your project. Your assignment is to design a conference management system. You will design the database, insert some sample data, and implement a set of required features in the backend. Each feature will be implemented as one Oracle PL/SQL procedure. You do NOT need to write a graphic user interface. You can test your features using SQL or PL/SQL scripts to call the implemented procedures. 
1. The system stores information about institutions (universities, companies, government), including an institution id, institution name, and country)
2. The system stores information about users, including a user ID, institution id, name, address, zipcode, email, and country. Each user is also affiliated with exactly one institution. 
3. The system stores information about conferences. Each conference has a conference ID, a conference title, a conference year, and the start and end date of the conference, submission due time (a timestamp), review due time, camera ready due time, a city and country, early registration date, early registration fee, regular registration fee. 
4. The system stores roles a user has at a conference. The roles can be organizer, author, reviewer, participant. A user can have multiple roles at a conference. Please store user id, conference id, and role. 
5. The system stores information about a paper. A paper has a paper ID, a title, a conference ID (the conference the paper is submitted to), submit time, average review score, and status (submitted, under review, accepted, rejected, camera ready received).
6. Each paper has one or more authors, each author is a user who has an author role for that conference. Each author can submit one or more papers to a conference. Please store paper id, author's user id, and author order (1 means first author and 2 second author and so on)
7. The system stores a list of topics, including a topic ID and a topic name. 
8. Each paper is associated with one or more topics. Each topic is associated with one or more papers. 
9. Reviewers are assigned to review a set of papers submitted to a conference. Each review consists of a review id, user id of the reviewer, paper id, review score, comments, review upload time. 
10. A user can register for a conference. The system stores registration id, conference id, user id, conference id, registration fee, and payment date and payment status (paid or not). 
11. The system stores a message table which contains message ID, user ID, message time, and message body. 

Features: There are five individual features and five group features. Individual features will be graded individually (your group member's individual feature will have no impact on your grade), but group features will be graded group-wise. So each group should work together to make sure the group features are done correctly. 
Each member needs to implement one individual feature. So if your group has X members your group will implement any X individual features. Each group also needs to implement any X group features. For example, if your group has five members, your group will do all 10 features. If your group has four members, your group will implement four individual features plus four group features. 


