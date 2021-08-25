class Employee
    
    attr_reader :name, :title, :salary, :boss

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss


    end

    def bonus(multiplier)
        @salary * multiplier
    end


end


class Manager < Employee

    def initialize(name, title, salary, boss, employees_assigned)
        super(name, title, salary, boss)
        @employees_assigned = employees_assigned

    end

    # have to go through all subordinates
    def bonus(multiplier)
        sub_emp_salaries = @employees_assigned.map {|employee| employee.salary}.sum
        sub_emp_salaries * multiplier
    end

end

emp1 = Employee.new("1", "TA", 10000, "3")
emp2 = Employee.new("2", "TA", 12000, "3")
emp3 = Manager.new("3", "TAP", 78000, "4", [emp1, emp2])
emp4 = Manager.new("4", "WAP", 1000000, nil, [emp1, emp2, emp3])

puts emp4.bonus(5)
puts emp3.bonus(4)
puts emp1.bonus(3)