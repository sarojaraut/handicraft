# In Object-Oriented Programming (OOP), we define classes that act as blueprints to create objects in Python with attributes and methods (functionality associated with the objects).


    # This is a general syntax to define a class:
    # class <className>:

    #     <class_attribute_name> = <value>

    #     def __init__(self,<param1>, <param2>, ...):
    #         self.<attr1> = <param1>
    #         self.<attr2> = <param2>
    #         .
    #         .
    #         .
    #         # As many attributes as needed
        
    #     def <method_name>(self, <param1>, ...):
    #         <code>

    #     # As many methods as needed

    # Notes: 
    #     self refers to an instance of the class (an object created with the class blueprint
    #     If the class inherits attributes and methods from another class, we will see the name of the class within parentheses: class Mom(FamilyMember):
    #     In Python, we write class name in Upper Camel Case, e.g. FamilyMember
    #     The objects will have attributes that we define in the class. Usually, we initialize these attributes in __init__. This is a method that runs when we create an instance of the class.
    #     Some classes will not require any arguments to create an instance. In that case, we just write empty parentheses, e.g.  def __init__(self):
    #     self is like a parameter that acts "behind the scenes", so even if you see it in the method definition, you shouldn't consider it when you pass the arguments.
    #     To access an instance attribute, we use this syntax: <object_variable>.<attribute>
    #     To remove an instance attribute, we use this syntax:del <object_variable>.<attribute>
    #     Similarly, we can delete an instance using del
    #     In Python, we don't have access modifiers to functionally restrict access to the instance attributes, so we rely on naming conventions to specify this, by adding a leading underscore, we can signal to other developers that an attribute is meant to be non-public.
    #     Use one leading underscore only for non-public methods and instance variables.
    #     Non-public attributes are those that are not intended to be used by third parties; you make no guarantees that non-public attributes won't change or even be removed.
    #     technically, we can still access and modify the attribute if we add the leading underscore to its name, but we shouldn't.
    #     Class attributes are shared by all instances of the class. They all have access to this attribute and they will also be affected by any changes made to these attributes. usually, they are written before the __init__ method.
    #     To get the value of a class attribute, we use this syntax: <class_name>.<attribute>
    #     To update a class attribute, we use this syntax: <class_name>.<attribute> = <value>
    #     We use del to delete a class attribute.
    #     Methods represent the functionality of the instances of the class. They are usually located below __init__:
    #     In Python, we typically use properties instead of getters and setters. Let's see how we can use them.
    #         To define a property, we write a method with this syntax:
    #             @property
    #             def <property_name>(self):
    #                 return self.<attribute>
    #         This method will act as a getter, so it will be called when we try to access the value of the attribute.
    #     Now, we may also want to define a setter:
    #         @<property_name>.setter
    #         def <property_name>(self, <param>):
    #             self.<attribute> = <param>
    #     And a deleter to delete the attribute:
    #         @<property_name>.deleter
    #         def <property_name>(self):
    #             del self.<attribute>

# My observation
    #  Only defining getter is throwing error while setting a value



class Dog:
    count = 0
    
    def __init__(self, nameval, ageval):
        self._name = nameval
        self._age =  ageval
    
    @property
    def name(self):
        print("Getter invoked")
        return self._name

    @property
    def age(self):
        print ("Age getter called")
        return self._age

    @name.setter
    def name(self, nameval):
        print("Setter invoked")
        self._name = nameval

    @age.setter
    def age(self, ageval):
        self._age = ageval

puppy = Dog('Puppy',10)
print (puppy._name)