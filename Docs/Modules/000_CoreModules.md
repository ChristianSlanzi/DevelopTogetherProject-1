# Core Modules

Core modules in an architecture are the most important ones. They are responsible for critical aspects of the application and those modules are required in all the applications built with the architecture.

- Database
- Networking
- ...

A core module may talk to other core modules, through an interface (boundaries), but won't direct talk or have any dependencies from modules beloging to the above layers.

