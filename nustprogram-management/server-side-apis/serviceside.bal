import ballerina/http;
import ballerina/time;

int port = 5000;



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


table<Programme> key (code) programme_t = table [{code: "123",nqf_level: "7", fac: "Computing", qual_title: "NUST", reg_date: "2022", courses: [{course_name: "Software", course_code:"32123", nqf_level: "4"}]},{code:"232",nqf_level: "4", fac: "Cpmuting", qual_title: "sfpt", reg_date: "2022", courses: [{course_name: "Softare", course_code:"123", nqf_level: "4"}]}];
table<Course> key(course_code) course_t = table [];


service /programme on new http:Listener(port){
   resource function get all() returns Programme[]{

        return programme_t.toArray();
    };

    resource function post insert_programme(Programme programme) returns string{
        //if programme_t.get(programme.code) == programme{
        //    return "The programme already exists";
        //}
        //else {
            programme_t.put(programme);
            return "The programme has been added";
        //}
            
    }

    resource function put update_programme/[string code] (Programme programme) returns Programme | string{

        if programme_t.hasKey(code){
             
            programme_t.put(programme);
            return "The programme has been updated";
        }
        else {
            return "The programme does not exist";
        }
    }

    resource function get code/[string code]() returns Programme | string{

        if programme_t.hasKey(code){
            return programme_t.get(code);
        } 
        else {
            return "The programme does not exist";
        }
    }

    resource function delete delete/[string code]() returns string{
        Programme result = programme_t.remove(code);
        return "The programme "+ result.qual_title+" - "+ result.code + "has been deleted";
    }

    resource function get due_review() returns Programme[]|error{
        time:Utc current_year_utc = time:utcNow();
        time:Civil current_year_civil = time:utcToCivil(current_year_utc);

        int current_year =  current_year_civil.year;

        table<Programme> due_programme = table[];
        foreach Programme programme in programme_t {
            string year = programme.reg_date;
            int year_int = check int:fromString(year);
            if((current_year - year_int) >= 5){
                due_programme.add(programme);
            }
        }
        return due_programme.toArray();
        
    }
    resource function get faculty/[string faculty]() returns Programme[]{
        table<Programme> programmes = programme_t.filter(pro => pro.fac == faculty); 
        return programmes.toArray();     
    }
    
}
