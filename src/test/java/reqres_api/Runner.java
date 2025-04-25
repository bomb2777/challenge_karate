package reqres_api;

import com.intuit.karate.junit5.Karate;

class Runner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("Pagination", "SchemaValidation", "UserAccount").relativeTo(getClass());
    }    

}
