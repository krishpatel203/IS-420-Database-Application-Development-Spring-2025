DROP TABLE Institutions CASCADE CONSTRAINTS;
DROP TABLE Users CASCADE CONSTRAINTS;
DROP TABLE Conferences CASCADE CONSTRAINTS;
DROP TABLE Roles CASCADE CONSTRAINTS;
DROP TABLE Papers CASCADE CONSTRAINTS;
DROP TABLE PaperAuthors CASCADE CONSTRAINTS;
DROP TABLE Topics CASCADE CONSTRAINTS;
DROP TABLE PaperTopic CASCADE CONSTRAINTS;
DROP TABLE Reviews CASCADE CONSTRAINTS;
DROP TABLE Registration CASCADE CONSTRAINTS;
DROP TABLE Messages CASCADE CONSTRAINTS;

DROP SEQUENCE seq_institution_id;
DROP SEQUENCE seq_user_id;
DROP SEQUENCE seq_conference_id;
DROP SEQUENCE seq_paper_id;
DROP SEQUENCE seq_topic_id;
DROP SEQUENCE seq_review_id;
DROP SEQUENCE seq_registration_id;
DROP SEQUENCE seq_message_id;

CREATE SEQUENCE seq_institution_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_user_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_conference_id START WITH 100 INCREMENT BY 1;
CREATE SEQUENCE seq_paper_id START WITH 200 INCREMENT BY 1;
CREATE SEQUENCE seq_topic_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_review_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_registration_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_message_id START WITH 1 INCREMENT BY 1;

CREATE TABLE Institutions (
    institution_id NUMBER,
    institution_name VARCHAR(225),
    country VARCHAR(225),
    PRIMARY KEY (institution_id)
);

CREATE TABLE Users (
    user_id NUMBER,
    institution_id NUMBER,
    name VARCHAR(100),
    address VARCHAR(200),
    zip_code VARCHAR(10),
    email VARCHAR(100),
    country VARCHAR(50),
    PRIMARY KEY (user_id),
    FOREIGN KEY (institution_id) REFERENCES Institutions (institution_id)
);

CREATE TABLE Conferences (
    conference_id NUMBER,
    conference_title VARCHAR(200),
    conference_year NUMBER,
    start_date DATE,
    end_date DATE,
    submission_due_time TIMESTAMP,
    review_due_time TIMESTAMP,
    camera_ready_due_time TIMESTAMP,
    city VARCHAR(100),
    country VARCHAR(50),
    early_registration_date DATE,
    early_registration_fee NUMBER,
    regular_registration_fee NUMBER,
    PRIMARY KEY (conference_id)
);

CREATE TABLE Roles (
    user_id NUMBER,
    conference_id NUMBER,
    role VARCHAR(50),
    PRIMARY KEY (user_id, conference_id, role),
    FOREIGN KEY (user_id) REFERENCES Users (user_id),
    FOREIGN KEY (conference_id) REFERENCES Conferences (conference_id)
);

CREATE TABLE Papers (
    paper_id NUMBER PRIMARY KEY,
    title VARCHAR(255),
    conference_id NUMBER,
    submit_time TIMESTAMP,
    average_review_score NUMBER(3,2),
    status VARCHAR(50),
    FOREIGN KEY (conference_id) REFERENCES Conferences(conference_id)
);

CREATE TABLE PaperAuthors (
    paper_id NUMBER,
    user_id NUMBER,
    author_order NUMBER,
    PRIMARY KEY (paper_id, user_id),
    FOREIGN KEY (paper_id) REFERENCES Papers(paper_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Topics (
    topic_id NUMBER,
    topic_name VARCHAR(225),
    PRIMARY KEY (topic_id)
);

CREATE TABLE PaperTopic (
    paper_id NUMBER,
    topic_id NUMBER,
    PRIMARY KEY (paper_id, topic_id),
    FOREIGN KEY (paper_id) REFERENCES Papers(paper_id),
    FOREIGN KEY (topic_id) REFERENCES Topics(topic_id)
);

CREATE TABLE Reviews (
    review_id NUMBER PRIMARY KEY,
    user_id NUMBER,
    paper_id NUMBER,
    review_score NUMBER(3,2),
    comments VARCHAR(1000),
    review_upload_time TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (paper_id) REFERENCES Papers(paper_id)
);

CREATE TABLE Registration (
    registration_id NUMBER PRIMARY KEY,
    conference_id NUMBER,
    user_id NUMBER,
    registration_fee NUMBER,
    payment_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (conference_id) REFERENCES Conferences (conference_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

CREATE TABLE Messages (
    message_id NUMBER,
    user_id NUMBER,
    message_time TIMESTAMP,
    message_body VARCHAR(225),
    PRIMARY KEY (message_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert statements
INSERT INTO Institutions VALUES (seq_institution_id.NEXTVAL, 'MIT', 'USA');
INSERT INTO Institutions VALUES (seq_institution_id.NEXTVAL, 'Oxford', 'UK');
INSERT INTO Institutions VALUES (seq_institution_id.NEXTVAL, 'Harvard', 'USA');

INSERT INTO Users VALUES (seq_user_id.NEXTVAL, 1, 'John Doe', '123 Main St, Cambridge', '02138', 'johndoe@harvard.edu', 'USA');
INSERT INTO Users VALUES (seq_user_id.NEXTVAL, 2, 'Jane Smith', '456 Stanford Way, Stanford', '94305', 'janesmith@stanford.edu', 'USA');
INSERT INTO Users VALUES (seq_user_id.NEXTVAL, 3, 'Alice Johnson', '789 Trinity Ln, Cambridge', 'CB2 1TN', 'alice.johnson@cam.ac.uk', 'UK');

INSERT INTO Conferences VALUES (seq_conference_id.NEXTVAL, 'International Conference on AI', 2025, DATE '2025-06-01', DATE '2025-06-05', TIMESTAMP '2025-03-01 23:59:59', TIMESTAMP '2025-04-01 23:59:59', TIMESTAMP '2025-05-01 23:59:59', 'Boston', 'USA', DATE '2025-05-01', 300.00, 500.00);
INSERT INTO Conferences VALUES (seq_conference_id.NEXTVAL, 'European Conference on Data Science', 2025, DATE '2025-07-10', DATE '2025-07-15', TIMESTAMP '2025-04-10 23:59:59', TIMESTAMP '2025-05-10 23:59:59', TIMESTAMP '2025-06-10 23:59:59', 'London', 'UK', DATE '2025-06-01', 250.00, 450.00);
INSERT INTO Conferences VALUES (seq_conference_id.NEXTVAL, 'Asia-Pacific Symposium on Neural Networks', 2025, DATE '2025-08-20', DATE '2025-08-25', TIMESTAMP '2025-05-20 23:59:59', TIMESTAMP '2025-06-20 23:59:59', TIMESTAMP '2025-07-20 23:59:59', 'Tokyo', 'Japan', DATE '2025-07-01', 200.00, 400.00);

INSERT INTO Roles VALUES (1, 100, 'Organizer');
INSERT INTO Roles VALUES (2, 101, 'Author');
INSERT INTO Roles VALUES (3, 102, 'Reviewer');

INSERT INTO Papers VALUES (seq_paper_id.NEXTVAL, 'AI in Healthcare', 100, TIMESTAMP '2025-02-15 14:30:00', NULL, 'Submitted');
INSERT INTO Papers VALUES (seq_paper_id.NEXTVAL, 'Ethical Machine Learning', 101, TIMESTAMP '2025-03-01 10:00:00', NULL, 'Under Review');
INSERT INTO Papers VALUES (seq_paper_id.NEXTVAL, 'Secure Federated Learning', 102, TIMESTAMP '2025-03-10 09:00:00', NULL, 'Submitted');

INSERT INTO PaperAuthors VALUES (200, 1, 1); 
INSERT INTO PaperAuthors VALUES (201, 2, 1);  
INSERT INTO PaperAuthors VALUES (202, 3, 1); 

INSERT INTO Topics VALUES (seq_topic_id.NEXTVAL, 'AI');
INSERT INTO Topics VALUES (seq_topic_id.NEXTVAL, 'Ethics');
INSERT INTO Topics VALUES (seq_topic_id.NEXTVAL, 'Cybersecurity');

INSERT INTO PaperTopic VALUES (200, 1); 
INSERT INTO PaperTopic VALUES (201, 2);  
INSERT INTO PaperTopic VALUES (202, 1);  
INSERT INTO PaperTopic VALUES (202, 3); 

INSERT INTO Reviews VALUES (seq_review_id.NEXTVAL, 3, 200, 4.5, 'Excellent research and relevance.', TIMESTAMP '2025-03-20 08:00:00');
INSERT INTO Reviews VALUES (seq_review_id.NEXTVAL, 1, 201, 3.5, 'Solid contribution but needs more clarity.', TIMESTAMP '2025-03-21 11:15:00');
INSERT INTO Reviews VALUES (seq_review_id.NEXTVAL, 2, 202, NULL, 'Incomplete review, missing score.', TIMESTAMP '2025-03-22 10:45:00');

INSERT INTO Registration VALUES (seq_registration_id.NEXTVAL, 100, 1, 300.00, DATE '2025-04-15', 'paid');
INSERT INTO Registration VALUES (seq_registration_id.NEXTVAL, 101, 2, 450.00, DATE '2025-06-05', 'unpaid');
INSERT INTO Registration VALUES (seq_registration_id.NEXTVAL, 102, 3, 400.00, DATE '2025-07-10', 'paid');

INSERT INTO Messages VALUES (seq_message_id.NEXTVAL, 1, SYSTIMESTAMP, 'message 1');
INSERT INTO Messages VALUES (seq_message_id.NEXTVAL, 1, SYSTIMESTAMP, 'message 2');
INSERT INTO Messages VALUES (seq_message_id.NEXTVAL, 1, SYSTIMESTAMP, 'message 3');








--(Eman) Feature 1. Add a user
CREATE OR REPLACE PROCEDURE add_user (
    p_name IN VARCHAR,
    p_institution_id IN NUMBER,
    p_address IN VARCHAR,
    p_zip_code IN VARCHAR,
    p_email IN VARCHAR,
    p_country IN VARCHAR
) IS
    v_inst_count NUMBER;
    v_email_count NUMBER;
    v_user_id NUMBER;
BEGIN
    -- Check if institution exists
    SELECT COUNT(*) INTO v_inst_count
    FROM Institutions
    WHERE institution_id = p_institution_id;

    IF v_inst_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid institution ID');
        RETURN;
    END IF;

    -- Check if email already exists
    SELECT COUNT(*) INTO v_email_count
    FROM Users
    WHERE email = p_email;

    IF v_email_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('User with this email already exists');
        RETURN;
    END IF;

    -- Get next user ID
    SELECT seq_user_id.NEXTVAL INTO v_user_id FROM dual;

    -- Insert user
    INSERT INTO Users (
        user_id, institution_id, name, address, zip_code, email, country
    ) VALUES (
        v_user_id, p_institution_id, p_name, p_address, p_zip_code, p_email, p_country
    );

    DBMS_OUTPUT.PUT_LINE('User ' || p_name || ' has been successfully added with ID ' || v_user_id);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

select * from users;

-- Normal Case: Adds a new user (if institution exists and email is new)
SET SERVEROUTPUT ON;
BEGIN
    add_user(
        'Michael Brown',
        1,
        '789 Tech Lane, Boston',
        '02139',
        'michael.brown@mit.edu',
        'USA'
    );
END;
/
select * from users;

-- Special Case 1: Invalid institution (institution_id = 999)
SET SERVEROUTPUT ON;
BEGIN
    add_user(
        'Linda Green',
        999,
        '456 Elm St, Boston',
        '02139',
        'linda.green@unknown.edu',
        'USA'
    );
END;
/
select * from users;



-- Special Case 2: Duplicate email (already in the Users table)
SET SERVEROUTPUT ON;
BEGIN
    add_user(
        'John Doe',
        1,
        '123 Main St, Cambridge',
        '02138',
        'johndoe@harvard.edu',
        'USA'
    );
END;
/
select * from users;





--(Krish) Feature 2. Add a list of roles at a user conference
CREATE OR REPLACE TYPE role_array AS VARRAY(10) OF VARCHAR2(50);
/

CREATE OR REPLACE PROCEDURE add_user_roles (
    user_id IN NUMBER,
    conference_id IN NUMBER,
    roles IN role_array
) IS
    invalid_user_or_conference EXCEPTION;
    role_count NUMBER;
    user_count NUMBER;
    conference_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO user_count
    FROM Users
    WHERE user_id = add_user_roles.user_id;

    SELECT COUNT(*) INTO conference_count
    FROM Conferences
    WHERE conference_id = add_user_roles.conference_id;

    IF user_count = 0 OR conference_count = 0 THEN
        RAISE invalid_user_or_conference;
    END IF;

    FOR i IN 1..roles.COUNT LOOP
        SELECT COUNT(*)
        INTO role_count
        FROM Roles
        WHERE user_id = add_user_roles.user_id
          AND conference_id = add_user_roles.conference_id
          AND role = roles(i);

        IF role_count = 0 THEN
            INSERT INTO Roles (user_id, conference_id, role)
            VALUES (add_user_roles.user_id, add_user_roles.conference_id, roles(i));

            DBMS_OUTPUT.PUT_LINE('New role "' || roles(i) || '" added for user ID ' || add_user_roles.user_id || 
                                 ' at conference ID ' || add_user_roles.conference_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Role "' || roles(i) || '" already exists for user ID ' || add_user_roles.user_id || 
                                 ' at conference ID ' || add_user_roles.conference_id);
        END IF;
    END LOOP;

EXCEPTION
    WHEN invalid_user_or_conference THEN
        DBMS_OUTPUT.PUT_LINE('Invalid user or conference ID');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/





DELETE FROM Roles
WHERE user_id = 1 AND conference_id = 100 AND role IN ('Organizer', 'Author');




-- Normal Case: Assigns 'Organizer' and 'Author' to user 1 for conference 100
SET SERVEROUTPUT ON;
DECLARE
    roles role_array := role_array('Organizer', 'Author');
BEGIN
    add_user_roles(1, 100, roles);
END;
/
SELECT * FROM Roles;





-- Special Case 1: Invalid user and conference IDs
SET SERVEROUTPUT ON;
DECLARE
    roles role_array := role_array('Organizer');  
BEGIN
    add_user_roles(99, 1001, roles);
END;
/
SELECT * FROM Roles;



-- Special Case 2: Assigns new role ('Reviewer') to user 3 for conference 102 but it already exists
SET SERVEROUTPUT ON;
DECLARE
    roles role_array := role_array('Reviewer');
BEGIN
    add_user_roles(3, 102, roles);
END;
/
SELECT * FROM Roles;






--(Amar) Feature 3. List papers submitted to a conference on a topic
CREATE OR REPLACE PROCEDURE LIST_PAPERS_BY_TOPIC_CONF (
    p_conference_id IN NUMBER,
    p_topic_id IN NUMBER
)
IS
    v_conf_exists NUMBER := 0;
    v_topic_exists NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_conf_exists
    FROM Conferences
    WHERE conference_id = p_conference_id;

    SELECT COUNT(*) INTO v_topic_exists
    FROM Topics
    WHERE topic_id = p_topic_id;

    IF NVL(v_conf_exists, 0) != 1 OR NVL(v_topic_exists, 0) != 1 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid conference or topic id');
        RETURN;
    END IF;

    FOR rec IN (
        SELECT p.paper_id, p.title
        FROM Papers p
        JOIN PaperTopic pt ON p.paper_id = pt.paper_id
        WHERE p.conference_id = p_conference_id
          AND pt.topic_id = p_topic_id
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('The id and title from that topic is ' || rec.paper_id || ' and ' || rec.title);
    END LOOP;
END;
/


-- Normal Case: Lists papers for conference 100 and topic 1
SET SERVEROUTPUT ON;
BEGIN
    LIST_PAPERS_BY_TOPIC_CONF(100, 1);
END;
/
select * from papers;

-- Special Case 1: Invalid conference
SET SERVEROUTPUT ON;
BEGIN
    LIST_PAPERS_BY_TOPIC_CONF(9999, 1);
END;
/
select * from papers;


-- Special Case 2: Invalid topic
SET SERVEROUTPUT ON;
BEGIN
    LIST_PAPERS_BY_TOPIC_CONF(100, 9999);
END;
/
select * from papers;






--(Aliza) Feature 4. list reviews of the paper
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE list_reviews(p_paper_id IN NUMBER) AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Papers WHERE paper_id = p_paper_id;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid paper ID');
        RETURN;
    END IF;
    
    FOR rec IN (
        SELECT r.review_id, u.name AS reviewer_name, i.institution_name, 
               NVL(TO_CHAR(r.review_score), 'Score missing') AS review_score
        FROM Reviews r
        JOIN Users u ON r.user_id = u.user_id
        JOIN Institutions i ON u.institution_id = i.institution_id
        WHERE r.paper_id = p_paper_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Review ID: ' || rec.review_id || 
                             ', Reviewer: ' || rec.reviewer_name || 
                             ', Institution: ' || rec.institution_name || 
                             ', Score: ' || rec.review_score);
    END LOOP;
END;
/




-- Normal Case: Valid paper with reviews
BEGIN
    list_reviews(200);
END;
/
select * from reviews;

-- Special Case 1: Invalid paper
BEGIN
    list_reviews(999);
END;
/
select * from reviews;


-- Special Case 2: Valid paper but review has missing score
BEGIN
    list_reviews(202);
END;
/
select * from reviews;










--(Eman) feature 5: Update the status of a paper
CREATE OR REPLACE PROCEDURE update_paper_status (
    p_paper_id IN NUMBER
) IS
    v_paper_count NUMBER;
    v_review_count NUMBER;
    v_avg_score NUMBER(3,2);
    v_new_status VARCHAR2(50);
BEGIN
    -- Check if paper exists
    SELECT COUNT(*) INTO v_paper_count
    FROM Papers
    WHERE paper_id = p_paper_id;

    IF v_paper_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid paper ID');
        RETURN;
    END IF;

    -- Count reviews with non-null scores
    SELECT COUNT(review_score)
    INTO v_review_count
    FROM Reviews
    WHERE paper_id = p_paper_id
      AND review_score IS NOT NULL;

    IF v_review_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No reviews are available for this paper');
        RETURN;
    END IF;

    -- Calculate average review score
    SELECT AVG(review_score)
    INTO v_avg_score
    FROM Reviews
    WHERE paper_id = p_paper_id
      AND review_score IS NOT NULL;

    -- Determine new status based on score
    IF v_avg_score >= 4.0 THEN
        v_new_status := 'Accepted';
    ELSIF v_avg_score >= 3.0 THEN
        v_new_status := 'Minor Revision';
    ELSIF v_avg_score >= 2.0 THEN
        v_new_status := 'Major Revision';
    ELSE
        v_new_status := 'Rejected';
    END IF;

    -- Update paper status and average score
    UPDATE Papers
    SET average_review_score = v_avg_score,
        status = v_new_status
    WHERE paper_id = p_paper_id;

    DBMS_OUTPUT.PUT_LINE('Paper ID ' || p_paper_id ||
                         ' updated with average score ' || v_avg_score ||
                         ' and status ' || v_new_status);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

-- Normal Case: Paper with valid reviews
SET SERVEROUTPUT ON;
BEGIN
    update_paper_status(200);
END;
/
SELECT paper_id, average_review_score, status FROM Papers WHERE paper_id = 200;
select * from papers;


-- Special Case 1: Paper with no review scores
SET SERVEROUTPUT ON;
BEGIN
    update_paper_status(202);
END;
/
select * from papers;


-- Special Case 2: Invalid paper ID
SET SERVEROUTPUT ON;
BEGIN
    update_paper_status(999);
END;
/
select * from papers;









--group feature 6: enter a review
CREATE OR REPLACE PROCEDURE enter_review (
    p_user_id        IN NUMBER,
    p_paper_id       IN NUMBER,
    p_review_score   IN NUMBER,
    p_review_comment IN VARCHAR2,
    p_upload_time    IN TIMESTAMP
) IS
    v_user_count        NUMBER;
    v_paper_count       NUMBER;
    v_role_count        NUMBER;
    v_conflict_count    NUMBER;
    v_review_exists     NUMBER;
    v_user_institution  VARCHAR2(100);
BEGIN
    -- Check if user and paper exist
    SELECT COUNT(*) INTO v_user_count FROM Users WHERE user_id = p_user_id;
    SELECT COUNT(*) INTO v_paper_count FROM Papers WHERE paper_id = p_paper_id;

    IF v_user_count = 0 OR v_paper_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid user ID or paper ID');
        RETURN;
    END IF;

    -- Check if user has a reviewer role
    SELECT COUNT(*) INTO v_role_count
    FROM Roles
    WHERE user_id = p_user_id AND role = 'Reviewer';

    IF v_role_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('this user is not a reviewer');
        RETURN;
    END IF;

    -- Get user's institution
    SELECT i.institution_name
    INTO v_user_institution
    FROM Users u
    JOIN Institutions i ON u.institution_id = i.institution_id
    WHERE u.user_id = p_user_id;

    -- Check for Conflict of Interest
    SELECT COUNT(*) INTO v_conflict_count
    FROM PaperAuthors pa
    JOIN Users u ON pa.user_id = u.user_id
    JOIN Institutions i ON u.institution_id = i.institution_id
    WHERE pa.paper_id = p_paper_id
      AND i.institution_name = v_user_institution;

    IF v_conflict_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('A COI exists');
        RETURN;
    END IF;

    -- Check if review already exists
    SELECT COUNT(*) INTO v_review_exists
    FROM Reviews
    WHERE user_id = p_user_id AND paper_id = p_paper_id;

    IF v_review_exists > 0 THEN
        UPDATE Reviews
        SET review_score = p_review_score,
            comments = p_review_comment,
            review_upload_time = p_upload_time
        WHERE user_id = p_user_id AND paper_id = p_paper_id;

        DBMS_OUTPUT.PUT_LINE('Update existing review');
    ELSE
        INSERT INTO Reviews (
            review_id,
            user_id,
            paper_id,
            review_score,
            comments,
            review_upload_time
        )
        VALUES (
            seq_review_id.NEXTVAL,
            p_user_id,
            p_paper_id,
            p_review_score,
            p_review_comment,
            p_upload_time
        );

        DBMS_OUTPUT.PUT_LINE('Review added');
    END IF;
END;
/


DELETE FROM Reviews
WHERE user_id = 3 AND paper_id = 201;



-- Normal Case: Valid reviewer, new review
SET SERVEROUTPUT ON;
BEGIN
    enter_review(
        p_user_id        => 3,      -- Valid reviewer
        p_paper_id       => 201,    -- Valid paper
        p_review_score   => 4.6,
        p_review_comment => 'Well-written and insightful.',
        p_upload_time    => SYSTIMESTAMP
    );
END;
/
select * from reviews;

-- Special Case 1: Invalid user or paper
SET SERVEROUTPUT ON;
BEGIN
    enter_review(
        p_user_id        => 9999,    -- Invalid user
        p_paper_id       => 201,     
        p_review_score   => 4.0,
        p_review_comment => 'Invalid user test.',
        p_upload_time    => SYSTIMESTAMP
    );
END;
/
select * from reviews;


-- Special Case 2: User without 'Reviewer' role
SET SERVEROUTPUT ON;
BEGIN
    enter_review(
        p_user_id        => 1,       
        p_paper_id       => 201,
        p_review_score   => 3.5,
        p_review_comment => 'User without reviewer role.',
        p_upload_time    => SYSTIMESTAMP
    );
END;
/
select * from reviews;


-- Special Case 3: COI — reviewer is from same institution as author
SET SERVEROUTPUT ON;
BEGIN
    enter_review(
        p_user_id        => 2,
        p_paper_id       => 200,
        p_review_score   => 3.8,
        p_review_comment => 'COI test.',
        p_upload_time    => SYSTIMESTAMP
    );
END;
/
select * from reviews;





--group feature 7: send a review reminder
CREATE OR REPLACE PROCEDURE send_review_reminder (
    p_conference_id IN NUMBER,
    p_input_time    IN TIMESTAMP
) IS
    v_conf_count    NUMBER;
    v_message_id    NUMBER;
BEGIN
    -- Check if conference exists
    SELECT COUNT(*) INTO v_conf_count
    FROM Conferences
    WHERE conference_id = p_conference_id;

    IF v_conf_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('invalid conference ID');
        RETURN;
    END IF;

    -- Loop through incomplete reviews
    FOR rec IN (
        SELECT r.user_id, r.paper_id
        FROM Reviews r
        JOIN Papers p ON r.paper_id = p.paper_id
        JOIN Conferences c ON p.conference_id = c.conference_id
        WHERE c.conference_id = p_conference_id
          AND c.review_due_time < p_input_time
          AND (r.review_score IS NULL OR r.comments IS NULL)
    )
    LOOP
        -- Insert message
        SELECT seq_message_id.NEXTVAL INTO v_message_id FROM dual;

        INSERT INTO Messages (
            message_id,
            user_id,
            message_time,
            message_body
        ) VALUES (
            v_message_id,
            rec.user_id,
            SYSTIMESTAMP,
            'Your review for paper ' || rec.paper_id || 
            ' submitted to conference ' || p_conference_id || 
            ' is past-due, please upload your review asap'
        );

        DBMS_OUTPUT.PUT_LINE('Sent reminder to user ' || rec.user_id || ' for missing review for paper ' || rec.paper_id);
    END LOOP;
END;
/


-- Normal Case: Valid conference with late/incomplete reviews
SET SERVEROUTPUT ON;
BEGIN
    send_review_reminder(100, SYSTIMESTAMP);
END;
/
select * from messages;


-- Special Case 1: Invalid conference ID
SET SERVEROUTPUT ON;
BEGIN
    send_review_reminder(
        p_conference_id => 9999,
        p_input_time    => SYSTIMESTAMP
    );
END;
/
select * from messages;



-- Special Case 2: Valid conference but no reviews meet the condition (silent pass)
SET SERVEROUTPUT ON;
BEGIN
    send_review_reminder(
        p_conference_id => 102,   -- assuming no overdue reviews
        p_input_time    => SYSTIMESTAMP
    );
END;
/
select * from messages;




--group feature 8: register a user for a conference
CREATE OR REPLACE PROCEDURE Register_User_For_Conference (
    p_user_id          NUMBER,
    p_conference_id    NUMBER,
    p_current_date     DATE,
    p_payment_status   VARCHAR2
) AS
    v_early_registration_date   DATE;
    v_early_registration_fee    NUMBER;
    v_regular_registration_fee  NUMBER;
    v_registration_fee          NUMBER;
    v_count                     NUMBER;
    v_registration_id           NUMBER;
    v_message_id                NUMBER;
    v_existing_payment_status   VARCHAR2(20);
BEGIN
    -- Check if user exists
    SELECT COUNT(*) INTO v_count FROM Users WHERE user_id = p_user_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid user ID');
        RETURN;
    END IF;

    -- Check if conference exists
    SELECT COUNT(*) INTO v_count FROM Conferences WHERE conference_id = p_conference_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid conference ID');
        RETURN;
    END IF;

    -- Check if user already registered
    SELECT COUNT(*) INTO v_count
    FROM Registration
    WHERE user_id = p_user_id AND conference_id = p_conference_id;

    IF v_count > 0 THEN
        -- Get existing payment status
        SELECT payment_status INTO v_existing_payment_status
        FROM Registration
        WHERE user_id = p_user_id AND conference_id = p_conference_id;

        -- If payment status is changing
        IF v_existing_payment_status != p_payment_status THEN
            UPDATE Registration
            SET payment_status = p_payment_status,
                payment_date = p_current_date
            WHERE user_id = p_user_id AND conference_id = p_conference_id;

            DBMS_OUTPUT.PUT_LINE('Registration payment status has been updated.');

            SELECT seq_message_id.NEXTVAL INTO v_message_id FROM dual;

            INSERT INTO Messages (message_id, user_id, message_time, message_body)
            VALUES (
                v_message_id,
                p_user_id,
                SYSTIMESTAMP,
                'Your payment status has been updated to ' || p_payment_status
            );

            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Update status of an existing registration.');
        END IF;
    ELSE
        -- Get conference fee details
        SELECT early_registration_date, early_registration_fee, regular_registration_fee
        INTO v_early_registration_date, v_early_registration_fee, v_regular_registration_fee
        FROM Conferences WHERE conference_id = p_conference_id;

        -- Choose correct fee
        IF p_current_date <= v_early_registration_date THEN
            v_registration_fee := v_early_registration_fee;
        ELSE
            v_registration_fee := v_regular_registration_fee;
        END IF;

        -- Get new registration ID
        SELECT seq_registration_id.NEXTVAL INTO v_registration_id FROM dual;

        INSERT INTO Registration (
            registration_id, conference_id, user_id,
            registration_fee, payment_date, payment_status
        )
        VALUES (
            v_registration_id, p_conference_id, p_user_id,
            v_registration_fee, p_current_date, p_payment_status
        );

        DBMS_OUTPUT.PUT_LINE('User registered successfully with Registration ID: ' || v_registration_id);

        -- Add message
        SELECT seq_message_id.NEXTVAL INTO v_message_id FROM dual;

        INSERT INTO Messages (message_id, user_id, message_time, message_body)
        VALUES (
            v_message_id,
            p_user_id,
            SYSTIMESTAMP,
            'You are registered with status ' || p_payment_status
        );

        COMMIT;
    END IF;
END;
/




-- Normal Case: New registration
SET SERVEROUTPUT ON;
DECLARE
    v_user_id NUMBER := 1;
    v_conference_id NUMBER := 100;
    v_current_date DATE := DATE '2025-04-15';
    v_payment_status VARCHAR2(20) := 'paid';
BEGIN
    Register_User_For_Conference(v_user_id, v_conference_id, v_current_date, v_payment_status);
END;
/
SELECT * FROM Registration;


-- Special Case 1: Update existing registration to new status
SET SERVEROUTPUT ON;
DECLARE
    v_user_id NUMBER := 1;
    v_conference_id NUMBER := 100;
    v_current_date DATE := DATE '2025-04-15';
    v_payment_status VARCHAR2(20) := 'unpaid';
BEGIN
    Register_User_For_Conference(v_user_id, v_conference_id, v_current_date, v_payment_status);
END;
/
SELECT * FROM Registration;
SELECT * FROM Messages;


-- Special Case 2: Invalid conference
    SET SERVEROUTPUT ON;
DECLARE
    v_user_id NUMBER := 1;
    v_conference_id NUMBER := 9999;
    v_current_date DATE := DATE '2025-04-30';
    v_payment_status VARCHAR2(20) := 'paid';
BEGIN
    Register_User_For_Conference(v_user_id, v_conference_id, v_current_date, v_payment_status);
END;
/
SELECT * FROM Registration;



-- Special Case 3: New registration for valid but different conference
SET SERVEROUTPUT ON;
DECLARE
    v_user_id NUMBER := 1;
    v_conference_id NUMBER := 102;
    v_current_date DATE := DATE '2025-06-18';
    v_payment_status VARCHAR2(20) := 'paid';
BEGIN
    Register_User_For_Conference(v_user_id, v_conference_id, v_current_date, v_payment_status);
END;
/
SELECT * FROM Registration;
SELECT * FROM Messages;





--group feature 9: Send a reminder to authors of papers that have been accepted but none of the authors has registered for the conference
--Insert statements for test cases
INSERT INTO Users VALUES (seq_user_id.NEXTVAL, 1, 'Bob Unregistered', '999 NoReg Ln, Nowhere', '00000', 'bob.unreg@example.com', 'USA');
INSERT INTO Papers VALUES (seq_paper_id.NEXTVAL, 'Unregistered AI Paper', 100, SYSTIMESTAMP, NULL, 'Accepted');
INSERT INTO PaperAuthors VALUES (203, 4, 1);

Set Serveroutput ON;
CREATE OR REPLACE PROCEDURE send_reg_reminder (
    p_conf_id IN NUMBER
) IS
    v_conf_count NUMBER;
    v_title VARCHAR2(200);
    v_early_date DATE;
BEGIN
    -- Step 1: Check if the conference exists
    SELECT COUNT(*) INTO v_conf_count
    FROM Conferences
    WHERE conference_id = p_conf_id;

    IF v_conf_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid conference ID');
        RETURN;
    END IF;

    -- Step 2: Get conference title and early registration date
    SELECT conference_title, early_registration_date
    INTO v_title, v_early_date
    FROM Conferences
    WHERE conference_id = p_conf_id;

    -- Step 3: Loop over accepted papers where authors are not registered
    FOR rec IN (
        SELECT DISTINCT u.name AS auth_name, pa.paper_id
        FROM Papers p
        JOIN PaperAuthors pa ON p.paper_id = pa.paper_id
        JOIN Users u ON pa.user_id = u.user_id
        WHERE p.conference_id = p_conf_id
          AND p.status = 'Accepted'
          AND NOT EXISTS (
              SELECT 1
              FROM Registration r
              WHERE r.user_id = pa.user_id AND r.conference_id = p_conf_id
          )
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Dear ' || rec.auth_name ||
                             ', your paper ' || rec.paper_id ||
                             ' has been accepted to Conference "' || v_title ||
                             '", please register by ' || TO_CHAR(v_early_date, 'YYYY-MM-DD') || '.');
    END LOOP;
END;
/


-- Run Test Case 1: Valid paper ID with unregistered author
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Test Case 1: Valid conference ID and author of accepted paper is not registered ---');
    send_reminder(100);
END;
/
-- Run Test Case 2: Valid paper ID with registered author
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Test Case 2: Valid paper ID with registered author ---');
    send_reminder(101);
END;
/
-- Run Test Case 3: Invalid paper ID
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Test Case 3: Invalid conference ID ---');
    send_reminder(999);
END;
/

--Check that message was added to messages table
select * from messages;
