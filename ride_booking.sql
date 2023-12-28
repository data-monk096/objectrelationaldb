--ROW TYPE OBJECT:
-- create an object to store vehicle details as Vehicle_OBJ;
CREATE OR REPLACE TYPE Vehicle_OBJ AS OBJECT(
    vehicle_id NUMBER,
    company_name VARCHAR2(20),
    vehicle_model VARCHAR2(20),
    vehicle_reg_num VARCHAR2(20),
    number_of_seats NUMBER,
    
    --Member function to check type of vehicle;
    MEMBER FUNCTION Check_type
    RETURN VARCHAR2 
);
-- Implement function Check_type
CREATE OR REPLACE TYPE BODY Vehicle_OBJ AS
    MEMBER FUNCTION Check_type RETURN VARCHAR2 IS
    BEGIN
        IF number_of_seats = 2 THEN
            RETURN 'Coupe';
        ELSIF number_of_seats >= 4 THEN
            RETURN 'Sedan';
        ELSIF number_of_seats >= 7 THEN
            RETURN 'SUV';
        ELSIF number_of_seats >= 8 THEN
            RETURN 'Minibus';
        ELSE
            RETURN 'Others';
        END IF;
    END Check_type;
END;

-- Create table vehicle usin Vehicle_OBJ;
-- The table is used to store type of vehicle used in app for providing service;
CREATE TABLE vehicle OF Vehicle_OBJ(
vehicle_id PRIMARY KEY);

-- Insert values into vehicle table
INSERT ALL
    INTO vehicle VALUES(Vehicle_OBJ(1, 'Mahindra', 'Bolero', 'SL-456', 4))
    INTO vehicle VALUES(Vehicle_OBJ(2, 'Toyota', 'Camry', 'ABC-456', 4))
    INTO vehicle VALUES(Vehicle_OBJ(3, 'BMW', 'X5', 'XYZ-789', 5))
    INTO vehicle VALUES(Vehicle_OBJ(4, 'Volkswagen', 'Golf', 'DEF-123', 4))
    INTO vehicle VALUES(Vehicle_OBJ(5, 'Mercedes', 'S-Class', 'LMN-456', 4))
    INTO vehicle VALUES(Vehicle_OBJ(6, 'Ford', 'Focus', 'PQR-789', 5))
    INTO vehicle VALUES(Vehicle_OBJ(7, 'Audi', 'A6', 'JKL-101', 4))
    INTO vehicle VALUES(Vehicle_OBJ(8, 'Renault', 'Clio', 'UVW-202', 3))
    INTO vehicle VALUES(Vehicle_OBJ(9, 'Peugeot', '208', 'IJK-303', 3))
    INTO vehicle VALUES(Vehicle_OBJ(10, 'Fiat', '500', 'RST-404', 2))
SELECT * FROM dual;

--Check if function is working correctly;
SET SERVEROUT ON
DECLARE
    V Vehicle_OBJ;
    v_type Varchar2(30);
BEGIN
    SELECT Vehicle_OBJ(vehicle_id,
                       company_name, 
                       vehicle_model, 
                       vehicle_reg_num, 
                       number_of_seats)
    INTO V
    FROM vehicle
    WHERE vehicle_id = 3;
    v_type := V.Check_type;
    DBMS_OUTPUT.PUT_LINE('Vehicle Type: ' || v_type);
END;

-------------------------------------------------------------------------------------------------

-- Create name_obj to store person name and surname i.e user and drivers;
CREATE OR REPLACE TYPE Person_OBJ AS OBJECT(
firstname VARCHAR2(50),
surname VARCHAR2(50),
gender VARCHAR2(6),
age NUMBER,
contact_number VARCHAR(20),
email_address VARCHAR(30),
p_password VARCHAR2(40),

MEMBER FUNCTION full_name RETURN VARCHAR2
);
--IMPLEMENT FUNCTION FULL_NAME to get full name
CREATE OR REPLACE TYPE BODY Person_OBJ AS
MEMBER FUNCTION full_name RETURN VARCHAR2
IS
BEGIN 
    RETURN firstname ||' '|| surname;
    END full_name;
END;

-- Create Address_OBJ to store for address:
CREATE OR REPLACE TYPE Address_OBJ AS OBJECT(
    address_id NUMBER,
    street_name VARCHAR2(100),
    house_number NUMBER,
    district VARCHAR2(30),
    city VARCHAR2(30),
    country VARCHAR2(40),
    pin_code VARCHAR(20),

    MEMBER FUNCTION full_address(add_id NUMBER) RETURN VARCHAR2
    );
    
--Implement function full_address;
CREATE OR REPLACE TYPE BODY Address_OBJ AS
MEMBER FUNCTION full_address(add_id NUMBER) RETURN VARCHAR2 IS
BEGIN
    IF address_id = add_id THEN
    RETURN address_id||','||street_name||','||house_number||','||district||','||city||','||country||','||pin_code;
    ELSE
        RETURN 'No matching address';
    END IF;
    END full_address;
END;

-- Create object Customer_OBJ using created objects;
CREATE OR REPLACE TYPE Customer_OBJ AS OBJECT(
    customer_id NUMBER,
    customer_details Person_OBJ,
    customer_address Address_OBJ
    );
    
--CREATE CUSTOMER TABLE
CREATE TABLE customer OF Customer_OBJ(
customer_id PRIMARY KEY
);

-- Insert data into customer table;
INSERT ALL
  INTO customer VALUES (1, Person_OBJ('Phurba','Sherpa','Male',23,'+371-34234324','phrbshr@gmail.com','332jaksflkasddj'),
  Address_OBJ(1,'Novembra Krastamala',22,'Riga','Riga','Latvia','LV-1050'))
  INTO customer VALUES (2, Person_OBJ('Laura','Johnson','Female',30,'+371-77777777','laura.johnson@email.com','abcdef12345'),
  Address_OBJ(2,'Main Street',10,'Riga','Riga','Latvia','LV-1020'))
  INTO customer VALUES (3, Person_OBJ('Michael','Brown','Male',45,'+371-888865578','michael.brown@email.com','12345abcde'),
  Address_OBJ(3,'Central Avenue',5,'Riga','Riga','Latvia','LV-1030'))
  INTO customer VALUES (4, Person_OBJ('Sophie','Miller','Female',28,'+371-99988899','sophie.miller@email.com','qwerty12345'),
  Address_OBJ(4,'Park Road',18,'Riga','Riga','Latvia','LV-1040'))
  INTO customer VALUES (5, Person_OBJ('Daniel','Taylor','Male',32,'+371-10101010','daniel.taylor@email.com','abc123def456'),
  Address_OBJ(5,'Sunset Boulevard',25,'Riga','Riga','Latvia','LV-1050'))
  INTO customer VALUES (6, Person_OBJ('Olivia','Anderson','Female',26,'+371-11110000','olivia.anderson@email.com','xyz987pqr321'),
  Address_OBJ(6,'River Street',30,'Riga','Riga','Latvia','LV-1060'))
  INTO customer VALUES (7, Person_OBJ('William','Clark','Male',38,'+371-12121212','william.clark@email.com','4567uvw8901'),
  Address_OBJ(7,'Forest Lane',12,'Riga','Riga','Latvia','LV-1070'))
  INTO customer VALUES (8, Person_OBJ('Emma','Turner','Female',22,'+371-13131313','emma.turner@email.com','mnopq67890rst'),
  Address_OBJ(8,'Mountain View',8,'Riga','Riga','Latvia','LV-1080'))
  INTO customer VALUES (9, Person_OBJ('Andrew','Carter','Male',40,'+371-14141414','andrew.carter@email.com','lmnop12345qrst'),
  Address_OBJ(9,'Ocean Drive',15,'Riga','Riga','Latvia','LV-1090'))
  INTO customer VALUES (10, Person_OBJ('Grace','Ward','Female',33,'+371-15151515','grace.ward@email.com','uvz67890abc'),
  Address_OBJ(10,'City Square',22,'Riga','Riga','Latvia','LV-1100'))
SELECT * FROM dual;

-- Create a procedure to get full name and address of any customer;
CREATE OR REPLACE PROCEDURE get_name_address(id_num NUMBER) IS
BEGIN
DECLARE
person person_obj;
address address_obj;
get_name VARCHAR2(100);
get_address VARCHAR2(100);
    BEGIN
    SELECT customer_details INTO person FROM customer WHERE customer_id = id_num;
    SELECT customer_address INTO address FROM customer WHERE customer_id = id_num;
    get_name := person.full_name;
    get_address := address.full_address(id_num);
    dbms_output.put_line('Full Name: ' || get_name ||',' ||'Full Address: '|| get_address);
    END;
END;
--Run procedure to check;
SET SERVEROUT ON
BEGIN
    get_name_address(9);
END;

--CREATE Review Object with referenct to customer table;
CREATE OR REPLACE TYPE Review_OBJ AS OBJECT(
review_id NUMBER,
driver_id NUMBER,
customer_ref REF Customer_OBJ,
comments VARCHAR2(200),
rating NUMBER
);

--CREATE review table;
CREATE TABLE review OF Review_OBJ(
review_id PRIMARY KEY);

--Alter review table;
ALTER TABLE review 
ADD (SCOPE FOR (customer_ref) IS Customer);

--Create procedure to add value to customer_ref in review table
CREATE OR REPLACE PROCEDURE add_customer_review(new_id NUMBER) IS
BEGIN
DECLARE
    customer_ref_var REF Customer_OBJ;
    BEGIN
        SELECT REF(C) INTO customer_ref_var
        FROM Customer C
        WHERE C.customer_id = new_id;
            
        UPDATE review R
        SET R.customer_ref = customer_ref_var
        WHERE R.review_id = new_id;
    END;
END add_customer_review;

--Insert data into review table;
INSERT ALL
    INTO review VALUES(Review_OBJ(1,2, NULL, 'Good', 4))
    INTO review VALUES(Review_OBJ(2,3, NULL, 'Excellent', 5))
    INTO review VALUES(Review_OBJ(3,5, NULL, 'Average', 3))
    INTO review VALUES(Review_OBJ(4,3, NULL, 'Great', 5))
    INTO review VALUES(Review_OBJ(5,6, NULL, 'Poor', 2))
    INTO review VALUES(Review_OBJ(6,4, NULL, 'Satisfactory', 3))
    INTO review VALUES(Review_OBJ(7,2, NULL, 'Fantastic', 5))
    INTO review VALUES(Review_OBJ(8,5, NULL, 'Decent', 4))
    INTO review VALUES(Review_OBJ(9,1, NULL, 'Superb', 5))
    INTO review VALUES(Review_OBJ(10,3,NULL,'Good',4))
SELECT * FROM dual;
--Adding customer_ref a reference with procedure;
BEGIN
    FOR i IN 1..10 LOOP
        BEGIN
            add_customer_review(i);
        END;
    END LOOP;
END;

--CREATING NESTE TABLE DATATYPE;
CREATE OR REPLACE TYPE review_coll_OBJ AS TABLE OF REVIEW_OBJ;

--CREATE TABLE DRIVER;
CREATE TABLE driver(
driver_id NUMBER PRIMARY KEY,
driver_details Person_OBJ,
driver_address Address_OBJ,
customer_rating review_coll_OBJ
)NESTED TABLE customer_rating STORE AS rating_ref_table;


--Create procedure to update_driver_review to insert value to rating_ref;
CREATE OR REPLACE PROCEDURE update_driver_review IS
BEGIN
    UPDATE driver d
    SET d.customer_rating = CAST(MULTISET(
                      SELECT * FROM review r
                      WHERE r.driver_id = d.driver_id
                    ) AS review_coll_OBJ);
    DBMS_OUTPUT.PUT_LINE('Table Update Successful');
END;


-- Insert into driver table;
INSERT ALL
    INTO driver VALUES(1,
        Person_OBJ('John', 'Doe', 'Male', 30, '+123-4567890', 'john.doe@example.com', '123abc'),
        Address_OBJ(1, 'Street1', 10, 'City1', 'State1', 'Latvia', '12345'),NULL)
    INTO driver VALUES(2,
        Person_OBJ('Alice', 'Smith', 'Female', 25, '+987-6543210', 'alice.smith@example.com', '456def'),
        Address_OBJ(2, 'Street2', 20, 'City2', 'State2', 'Latvia', '67890'),NULL)
    INTO driver VALUES(3,
        Person_OBJ('Bob', 'Johnson', 'Male', 35, '+111-2223333', 'bob.johnson@example.com', '789ghi'),
        Address_OBJ(3, 'Street3', 30, 'City3', 'State3', 'Latvia', '54321'),NULL)
    INTO driver VALUES(4,
        Person_OBJ('Lendup','Lama','Male',27,'+371-34454324','ldrr@gmail.com','332jasdflkasddj'),
        Address_OBJ(4,'Center',22,'Riga','Riga','Latvia','LV-1050'),NULL)    
SELECT * FROM dual;

--Update driver table rating with data from review table using following procedure;
BEGIN
    update_driver_review;
END;
--------------------------------------------------------------------------------------------------------------------
--CREATE LOACTION_OBJ;
CREATE OR REPLACE TYPE Location_OBJ AS OBJECT(
 latitude NUMBER,
 longitude NUMBER
 )

-- Create Ride_OBJ;
CREATE OR REPLACE TYPE Ride_OBJ as OBJECT(
trip_id NUMBER,
driver_id NUMBER,
customer_id NUMBER,
starting_location Location_obj,
end_location Location_obj,
ride_cost NUMBER,

--FUNCTION FOR RIDE_OBJ;
MEMBER FUNCTION total_no_trips(d_id NUMBER) RETURN NUMBER,
MEMBER FUNCTION total_earning(d_id NUMBER) RETURN NUMBER,
MEMBER FUNCTION earning_after_bonus(r_id NUMBER,bonus NUMBER) RETURN NUMBER
);

--Create ride details table;
CREATE TABLE ride_details OF Ride_OBJ(
trip_id PRIMARY KEY,
CONSTRAINT fk_driver_id FOREIGN KEY(driver_id) REFERENCES driver(driver_id),
CONSTRAINT fk_customer_id FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
);

--IMPLEMENT FUNCTION FOR RIDE_OBJ;
CREATE OR REPLACE TYPE BODY Ride_OBJ AS
MEMBER FUNCTION total_earning(d_id NUMBER) RETURN NUMBER IS
    total_earning_val NUMBER := 0;
    BEGIN
    IF driver_id = d_id THEN
        SELECT SUM(ride_cost) INTO total_earning_val
        FROM ride_details
        WHERE driver_id = d_id;
    RETURN total_earning_val;
    ELSE
        RETURN NULL;
    END IF;
  END;
MEMBER FUNCTION total_no_trips(d_id NUMBER) RETURN NUMBER IS 
    total_trips NUMBER := 0;
    BEGIN
        IF driver_id = d_id THEN
        SELECT COUNT(trip_id) INTO total_trips
        FROM ride_details
        WHERE driver_id = d_id;
    
        RETURN total_trips;
        ELSE
        RETURN NULL;
        END IF;
    END;
MEMBER FUNCTION earning_after_bonus(r_id NUMBER,bonus NUMBER) RETURN NUMBER IS
    bonus_earning NUMBER;
    rate_conv NUMBER := 0.90;
BEGIN
    IF trip_id = r_id THEN
        SELECT (ride_cost-(ride_cost * rate_conv )+bonus)
        INTO bonus_earning
        FROM ride_details
        WHERE trip_id = r_id;
        
        RETURN bonus_earning;
    ELSE
        RETURN NULL;
    END IF;
END;
END;

--INSERT trip details into ride_trip table;
INSERT ALL
    INTO ride_details VALUES(1,3,4,Location_OBJ( 56.94964870,24.10518650),Location_OBJ( 57.0803280039,25.10518650),4)
    INTO ride_details VALUES(2,4,1,Location_OBJ( 58.94964870,23.10518650),Location_OBJ( 57.0803280039,25.10518650),6)
    INTO ride_details VALUES(3,2,4,Location_OBJ( 55.94964870,25.10518650),Location_OBJ( 58.0803280039,29.10518650),6)
    INTO ride_details VALUES(4,1,3,Location_OBJ( 52.94964870,25.10518650),Location_OBJ( 57.0803280039,22.10518650),7)
    INTO ride_details VALUES(5,1,3,Location_OBJ( 55.94964870,25.10518650),Location_OBJ( 57.0803280039,22.10518650),7)
    INTO ride_details VALUES(6,1,3,Location_OBJ( 52.94964870,25.10518650),Location_OBJ( 57.0803280039,29.10518650),10)
SELECT * FROM dual;


------------------------------------------------------------------------------------------------------------------------------------
--Create Booking_details Table to keep all the booking details;
CREATE TABLE booking_details (
booking_id NUMBER PRIMARY KEY NOT NULL,
trip_id NUMBER,
vehicle_id NUMBER,
customer_id NUMBER,
driver_id NUMBER,
review_id NUMBER,

CONSTRAINT fk_bk_trip_id FOREIGN KEY(trip_id) REFERENCES ride_details(trip_id),
CONSTRAINT fk_bk_vehicle_id FOREIGN KEY(vehicle_id) REFERENCES vehicle(vehicle_id),
CONSTRAINT fk_bk_customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
CONSTRAINT fk_bk_driver_id FOREIGN KEY(driver_id) REFERENCES driver(driver_id),
CONSTRAINT fk_bk_review_id FOREIGN KEY(review_id) REFERENCES review(review_id)
);

---Insert Data into booking table;
INSERT ALL 
    INTO booking_details VAlUES(1,3,3,4,2,3)
    INTO booking_details VALUES(2,2,4,4,2,1)
    INTO booking_details VALUES(3,2,4,4,3,2)
    INTO booking_details VALUES(4,2,1,4,4,4)
    INTO booking_details VALUES(5,2,3,4,1,2)
    INTO booking_details VALUES(6,2,2,1,2,4)
    INTO booking_details VALUES(7,2,4,4,1,5)
    INTO booking_details VALUES(8,2,5,3,3,1)
SELECT * FROM dual;




