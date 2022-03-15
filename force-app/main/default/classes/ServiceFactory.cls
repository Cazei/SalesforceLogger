public virtual class ServiceFactory {
    
    protected Map<Type, Type> m_serviceInterfaceTypeByServiceImplType;

    protected Map<Type, Object> m_serviceInterfaceTypeByMockService;

    
    public ServiceFactory() { }

  
    public ServiceFactory(Map<Type, Type> serviceInterfaceTypeByServiceImplType)
    {
        m_serviceInterfaceTypeByServiceImplType = serviceInterfaceTypeByServiceImplType;
        m_serviceInterfaceTypeByMockService = new Map<Type, Object>();
    }

    public virtual Object newInstance(Type serviceInterfaceType)
    {
        // Create an instance of the type implementing the given interface
        Type serviceImpl = m_serviceInterfaceTypeByServiceImplType.get(serviceInterfaceType);
        
        return serviceImpl.newInstance();
    }

}
