import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import static org.junit.Assert.assertEquals;


public class SimpleTest {
    private static WebDriver driver;

    @BeforeClass
    public static void setUp() throws Exception {
        System.setProperty("webdriver.chrome.driver", "D:/tools/chromedriver.exe");
        driver = new ChromeDriver();
        driver.get("https://www.baidu.com/");
        // System.out.println("网页名称:" + driver.getTitle());
        WebElement element = driver.findElement(By.cssSelector("#kw"));
        //        id选择器
        // WebElement element1 = driver.findElement(By.id("kw"));
        element.sendKeys("冷静和热情之间");
        element.submit();
        //Thread.sleep(10000);
        //driver.quit();
    }

    @Test
    public void testTitle() throws Exception {
        assertEquals("百度一下，你就知道", driver.getTitle());
    }

    @Test
    public void testSelector() {
        //assertEquals("冷静和热情之间",element.sendKeys("冷静和热情之间"));
        assertEquals("input", driver.findElement(By.cssSelector("#kw")).getTagName());
    }

    @Test
    public void testSend() {
        assertEquals("冷静和热情之间", driver.findElement(By.cssSelector("#kw")).getAttribute("value"));
    }


}
