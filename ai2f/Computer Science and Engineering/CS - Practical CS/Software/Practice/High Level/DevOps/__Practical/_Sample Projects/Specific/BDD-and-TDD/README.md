   
1. We have our gherkin in the calculator.feature file

        Feature: Calculator
        Scenario Outline: Expression Validation
            Given I am a user of the Calculator App
            When I enter <expression>
            Then The output is <expected>
        
        
        Examples: Math Expressions
            |   expression              |   expected|
            |   2 + 1 = 3               |   True    |
            |   2 + 10 = 12             |   True    |
            |   2 + 11 = 13             |   True    |
            |   2 + 101 = 3             |   False   |
            |   2 + 1093 = 12           |   False   |

2. We have implementations for the steps of our feature file e.g. for When I enter '2+1=3'

        @given(u'I am a user of the Calculator App')
        def step_impl(context):
            context.Calculator = Calculator()

        @when(u'I enter {expression}')
        def step_impl(context, expression):
            op = Operation(expression)
            context.output = context.Calculator.validate(op)
        
        
        @then(u'The output is {expected}')
        def step_impl(context, expected):
            assert_that(str(context.output)).is_equal_to(expected)

3. Now that we have our steps, change directory on terminal to features and run the feature test with the commands

        'cd test/features'
        'PYTHONPATH=../.. behave'
        
4. The tests predictably fail as we haven't built/developed this product/feature

5. So we are going to do this development under our src folder

6. Its at this point where TDD is usually introduced alongside BDD and that's why we have our unit_tests folder and the test_calculator.py file in it.

7. We can write tests to help us along developing the each bit (unit) of our overall feature

8. Let's say we want our Calculator to look like this and be a class:

           OPERATION_HANDLERS = [
                AdditionHandler()
            ]


        class Calculator:
            def validate(self, operation):
                for handler in OPERATION_HANDLERS:
                    if operation.operand == handler.eligible_operand:
                        return handler.check_operation_is_correct(operation)
                        
  
9.  Let's now look at building out our functionality

10. Let's write a test for what we want from our Operation class

            class TestOperation(TestCase):
                def test_operation(self):
                    operation = Operation('1 + 2 = 3')
                    assert_that(operation.lhs).is_equal_to(1)
                    assert_that(operation.rhs).is_equal_to(2)
                    assert_that(operation.operand).is_equal_to('+')
                    assert_that(operation.result).is_equal_to(3)
                   
                   
10. Then we can develop our Operations class in operations.py
            
            REGEX = r'(\d+) ([+-/*]) (\d+) = (\d+)'

            class Operation:
               def __init__(self, string_input):
                  self.parsed_input = self.parse_input(string_input)
                  self.lhs = self.parsed_input[1]
                  self.operand = self.parsed_input[2]
                  self.rhs = self.parsed_input[3]
                  self.result = self.parsed_input[4]
                  
               def parse_input(string_input):
                  pattern = re.compile(REGEX)
                  parsed_input = pattern.match(string_input)
                  return parsed_input

11. We can then have tests for our handler

            class TestHandler(TestCase):
                def test_addition_handler(self):
                    handler = AdditionHandler()
                    operation = Operation('1 + 2 = 3')
                    output = handler.check_operation_is_correct(operation)
                    assert_that(handler.eligible_operand).is_equal_to('+')
                    assert_that(output).is_equal_to(True)
                    
12. Then we can build the handler
            
            class AdditionHandler:
                def __init__(self, operand):
                    self.eligible_operand = operand
                    
                def check_operation_is_correct(operation):
                    real_result = operation.lhs + operation.rhs
                    return real_result == operation.result



IMPORTANT COMMANDS:
-   Run Unit tests with Coverage.. (Go to the unit test directory first)
        
           PYTHONPATH=../.. coverage run --source=../../src -m unittest discover -v  && coverage report -m


NOTES:
- The branch 'solution' of this repo has a solution to this exercise which you can go through in your own time
          
    
   