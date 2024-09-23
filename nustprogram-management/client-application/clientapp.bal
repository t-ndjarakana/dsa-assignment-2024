import ballerina/io;
import ballerina/http;

type Course record {|
    string course_name;
    readonly string course_code;
    string nqf_level;
|};

type Programme record {|
    readonly string code;
    string nqf_level;
    string fac;
    string qual_title;
    string reg_date;   
    Course[] courses;
|};

public function main() returns error? {
    http:Client programmeClient = check new ("localhost:5000/programme");

    io:println("================================================");
    io:println("      Welcome to NUST Programme Management");
    io:println("================================================");
    io:println("==============       2024        ==================");
    io:println("===================Version 1.1==================");

    while true {
        printMenu();
        string choice = io:readln("\nPlease Choose what you would like to perform from(1-8)");

        match choice {
            "1" => { check createProgramme(programmeClient); }
            "2" => { check getAllProgrammes(programmeClient); }
            "3" => { check getProgrammeByCode(programmeClient); }
            "4" => { check updateProgramme(programmeClient); }
            "5" => { check deleteProgramme(programmeClient); }
            "6" => { check getDueForReview(programmeClient); }
            "7" => { check getProgrammesByFaculty(programmeClient); }
            "8" => { io:println("\nExiting Programme Management System."); break; }
            _ => { io:println("Invalid choice. Please try again."); }
        }
        io:println("\nPress Enter to continue...");
        _ = io:readln();
    }
}

function printMenu() {
    io:println("\n--------------------------------");
    io:println("    Programme Menu   ");
    io:println("--------------------------------");
    io:println("1. AddProgramme");
    io:println("2. Get All Programmes");
    io:println("3. Get Programme by Code");
    io:println("4. Update Programme");
    io:println("5. Delete Programme");
    io:println("6. Get Programmes Due for Review");
    io:println("7. Get Programmes by Faculty");
    io:println("8. Exit");
    io:println("--------------------------------");
}

function getAllProgrammes(http:Client httpClient) returns error? {
    Programme[] programmes = check httpClient->/all;
    io:println("\n--- All Programmes ---");
    foreach Programme programme in programmes {
        printProgrammeInfo(programme);
    }
}

function getProgrammeByCode(http:Client httpClient) returns error? {
    string code = io:readln("\nEnter Programme code: ");
    Programme|string result = check httpClient->/code/[code];
    if (result is Programme) {
        printProgrammeInfo(result);
    } else {
        io:println("\n[Error] Programme not found.");
    }
}

function getDueForReview(http:Client httpClient) returns error? {
    Programme[]|error response = httpClient->/due_review;
    io:println("\n--- Programmes Due for Review ---");
    
    if (response is Programme[]) {
        foreach Programme programme in response {
            printProgrammeInfo(programme);
        }
    } else {
        io:println("\n[Error] Unable to fetch programmes due for review:", response.message());
    }
}

function getProgrammesByFaculty(http:Client httpClient) returns error? {
    string faculty = io:readln("\nEnter Faculty: ");
    Programme[] programmes = check httpClient->/faculty/[faculty];
    io:println("\n--- Programmes in Faculty: ", faculty, " ---");
    foreach Programme programme in programmes {
        printProgrammeInfo(programme);
    }
}

function createProgramme(http:Client httpClient) returns error? {
    Programme programme = getProgrammeDetails();
    string result = check httpClient->/insert_programme.post(programme);
    io:println("\n[Success] Programme created successfully.");
}

function updateProgramme(http:Client httpClient) returns error? {
    string code = io:readln("\nEnter the code of the Programme to update: ");
    Programme existingProgramme = check httpClient->/code/[code];
    Programme updatedProgramme = getProgrammeDetails();
    
    string|Programme result = check httpClient->/update_programme/[code].put(updatedProgramme);
    io:println("\n[Success] Programme updated successfully.");
}

function deleteProgramme(http:Client httpClient) returns error? {
    string code = io:readln("\nEnter the code of the Programme to delete: ");
    Programme|string result = check httpClient->/code/[code];
    
    if (result is Programme) {
        string deleteResult = check httpClient->/delete/[code].delete();
        io:println("\n[Success] Programme deleted successfully.");
    } else {
        io:println("\n[Error] Programme with code", code, "does not exist.");
    }
}

function getProgrammeDetails() returns Programme {
    io:println("\n--- Enter Programme Details ---");
    Programme programme = {
        code: io:readln("Enter code: "),
        qual_title: io:readln("Enter qualification title: "),
        reg_date: io:readln("Enter registration date (YYYY-MM-DD): "),
        fac: io:readln("Enter faculty: "),
        nqf_level: io:readln("Enter NQF level: "),
        courses: []
    };

    string courseCountInput = io:readln("Enter number of courses: ");
    int|error courseCount = int:fromString(courseCountInput);

    if (courseCount is int) {
        foreach int i in 1...courseCount {
            io:println("\n--- Enter details for Course", i, "---");
            programme.courses.push(getCourseDetails());
        }
    } else {
        io:println("\n[Warning] Invalid number of courses. Setting course count to 0.");
    }

    return programme;
}

function getCourseDetails() returns Course {
    return {
        course_code: io:readln("Enter course code: "),
        course_name: io:readln("Enter course name: "),
        nqf_level: io:readln("Enter course NQF Level: ")
    };
}

function printProgrammeInfo(Programme programme) {
    io:println("\n--------------------------------");
    io:println("Code: ", programme.code);
    io:println("Qualification Title: ", programme.qual_title);
    io:println("Registration Date: ", programme.reg_date);
    io:println("Faculty: ", programme.fac);
    io:println("NQF Level: ", programme.nqf_level);
    io:println("Courses:");
    foreach Course course in programme.courses {
        io:println("  - ", course.course_code, ":", course.course_name, "(NQF Level:", course.nqf_level, ")");
    }
    io:println("--------------------------------");
}
