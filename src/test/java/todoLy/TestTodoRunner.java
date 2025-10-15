package todoLy;

import com.intuit.karate.junit5.Karate;

public class TestTodoRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("testTodoLy").relativeTo(getClass());
    }
}
