# Specific Modules

Specific modules are modules that implemts specific features of the application. They can be reused in similar applications that require the same feature, but they are not necessary for other categories of applications. They are often responsible for specif business logic aspects in the business domain of the application.

- Xxx
- Xxx
- ...

A specific module may have dependencies, through an interface, to modules beloging to the common layer and may talk to other specific modules, through an interface (boundaries), but won't direct talk or have any dependencies from modules beloging to the core layer.

