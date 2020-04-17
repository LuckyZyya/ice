
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.concurrent.TimeUnit;

public class TestAltoroLoginWithPageFactory {
    static WebDriver driver;
    AltoroLogin objLogin;
    AltoroHomePage objHomePage;

    @BeforeClass
    public static void setup() throws Exception{
        System.setProperty("webdriver.chrome.driver", "D:/tools/chromedriver.exe");
        driver = new ChromeDriver();
        //driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        driver.get("http://www.testfire.net/login.jsp");
    }

    @Test
    public void test_Home_Page_Appear_Correct(){
        //Create Login Page object
        objLogin = new AltoroLogin(driver);
        //login to application
        objLogin.loginToAltoro("admin", "admin");
        // go the next page
        objHomePage = new AltoroHomePage(driver);
        //Verify home page
        Assert.assertTrue(objHomePage.getHomePageUserName().toLowerCase().contains("congratulations!"));
    }
}
