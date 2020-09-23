# 代码整洁之道

* 函数的第一规则是要短小
* 函数应该做一件事,做好这件事
* 每个函数一个抽象层级。自顶向下读代码
  - 每个函数都应该保留一个抽象层级，而且尽量只做一件事
  - 抽象:指代要做的事情的概念，而不是具体的细节实现

```php
// 雇员抽象类
abstract class Employee {

    public function isPayday($date);

    public function calculatePay();

    public function deliverPay($money);
}

// 雇员工厂
interface EmployeeFactory {
    public function makeEmployee(EmployeeRecord $record);
}

// 工厂的具体实现
class EmployeeFactoryImpl implements EmployeeFactory {
    public function makeEmployee(EmployeeRecord $record)
    {
        switch ($record->type) {
        case COMMISSIONED :
            return new CommissionedEmployee($record);
        case HOURLY :
            return new HourlyEmployee($record);
        case SALARIED :
            return new SalariedEmployee($record);
        default:
            throw new InvalidEmployeeType($record->type);
    }
    }
}
```
