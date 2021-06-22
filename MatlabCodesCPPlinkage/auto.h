class Engine { 
private:
    int fNumberOfCylinders;
          
public: 
    Engine(int numcylinders) : fNumberOfCylinders(numcylinders), isServiced(false) {}
    int getNumCylinders() const { 
        return fNumberOfCylinders;
    }
    bool isServiced;
}; 

class Car {
private:
    Engine& fEngine;
public: 
    Car(Engine &engine): fEngine(engine) {}
    Engine& getEngine() { 
        return fEngine;
    } 
}; 