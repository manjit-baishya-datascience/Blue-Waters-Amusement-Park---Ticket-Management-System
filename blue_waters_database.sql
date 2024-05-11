-- Drop Table [Rides]
DROP TABLE IF EXISTS Rides;

-- Table to store information about rides in the amusement park
CREATE TABLE IF NOT EXISTS Rides (
  RideID INTEGER PRIMARY KEY,
  Name TEXT NOT NULL,
  Type TEXT NOT NULL,
  Capacity INTEGER NOT NULL,
  HeightRestriction DECIMAL(5, 2) NOT NULL, -- Minimum height requirement in meters
  AgeRestriction DECIMAL(5, 2), -- Minimum age requirement in years
  Priority TEXT CHECK (Priority IN ('High', 'Medium', 'Low')) DEFAULT 'Medium', -- Ride priority
  Status TEXT CHECK (Status IN ('Operational', 'Under Maintenance', 'Closed')) NOT NULL,
  LastMaintenance DATE,
  Location TEXT,
  Description TEXT,
  UNIQUE (Name),
  
  FOREIGN KEY (LastMaintenance) REFERENCES Maintenance(MaintenanceID) 
);

-- Drop Table [Visitors]
DROP TABLE IF EXISTS Visitors;

-- Table to store information about visitors
CREATE TABLE IF NOT EXISTS Visitors (
  VisitorID INTEGER PRIMARY KEY,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  Age INTEGER NOT NULL,
  Gender TEXT CHECK (Gender IN ('Male', 'Female', 'Other')) NOT NULL,
  Email TEXT UNIQUE NOT NULL,
  PhoneNumber TEXT,
  Address TEXT,
  City TEXT,
  State TEXT,
  Country TEXT,
  DateOfBirth DATE NOT NULL
);

-- Drop Table [Tickets]
DROP TABLE IF EXISTS Tickets;

-- Table to store tickets purchased by visitors
CREATE TABLE IF NOT EXISTS Tickets (
  TicketID INTEGER PRIMARY KEY,
  VisitorID INTEGER NOT NULL,
  RideID INTEGER NOT NULL,
  PurchaseDate DATETIME NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID),
  FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

-- Drop Table [Staff]
DROP TABLE IF EXISTS Staff;

-- Table to store information about staff members
CREATE TABLE IF NOT EXISTS Staff (
  StaffID INTEGER PRIMARY KEY,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  Position TEXT NOT NULL,
  Email TEXT UNIQUE NOT NULL,
  PhoneNumber TEXT,
  DateOfBirth DATE NOT NULL,
  DateJoined DATE NOT NULL,
  Salary DECIMAL(10, 2) NOT NULL,
  Address TEXT,
  City TEXT,
  State TEXT,
  Country TEXT
);

-- Drop Table [Facilities]
DROP TABLE IF EXISTS Facilities;

-- Table to store information about facilities in the amusement park
CREATE TABLE IF NOT EXISTS Facilities (
  FacilityID INTEGER PRIMARY KEY,
  Name TEXT NOT NULL,
  Description TEXT,
  Location TEXT,
  Capacity INTEGER,
  Status TEXT CHECK (Status IN ('Operational', 'Under Maintenance', 'Closed')) NOT NULL,
  LastMaintenanceDate DATE,
  UNIQUE (Name)
);

-- Drop Table [Maintenance]
DROP TABLE IF EXISTS Maintenance;

-- Table to store maintenance records for rides and facilities (consider if needed)
CREATE TABLE IF NOT EXISTS Maintenance (
  MaintenanceID INTEGER PRIMARY KEY,
  ItemID INTEGER NOT NULL, -- RideID or FacilityID
  ItemType TEXT CHECK (ItemType IN ('Ride', 'Facility')) NOT NULL,
  Description TEXT,
  MaintenanceDate DATE NOT NULL,
  Cost DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (ItemID) REFERENCES Rides(RideID) ON DELETE CASCADE,
  FOREIGN KEY (ItemID) REFERENCES Facilities(FacilityID) ON DELETE CASCADE
);

-- Drop Table [RideReviews]
DROP TABLE IF EXISTS RideReviews;

-- Table to store ride ratings and reviews by visitors
CREATE TABLE IF NOT EXISTS RideReviews (
  ReviewID INTEGER PRIMARY KEY,
  RideID INTEGER NOT NULL,
  VisitorID INTEGER NOT NULL,
  Rating INTEGER NOT NULL,
  Review TEXT,
  ReviewDate DATE NOT NULL,
  FOREIGN KEY (RideID) REFERENCES Rides(RideID),
  FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID)
);

-- Drop Table [RideAssignments]
DROP TABLE IF EXISTS RideAssignments;

-- Table to assign staff members to rides for operation and maintenance
CREATE TABLE IF NOT EXISTS RideAssignments (
  AssignmentID INTEGER PRIMARY KEY,
  RideID INTEGER NOT NULL,
  StaffID INTEGER NOT NULL,
  AssignmentType TEXT CHECK (AssignmentType IN ('Operation', 'Maintenance')) NOT NULL,
  AssignmentDate DATE NOT NULL,
  FOREIGN KEY (RideID)
