package ahhenderson.core.managers.dependency.facadeService.controller
{

    
    
    

    
    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     */
    public class AmfGroupedServiceCommand  
    {
         
       /* override public function execute( note:INotification ) :void    {
            
			const serviceRequestGroup:AmfServiceRequestGroup = note.getBody() as AmfServiceRequestGroup;
			
			if(!serviceRequestGroup)
				throw new Error(FacadeErrorConstants.SERVICE_REQUEST_GROUP_DOES_NOT_EXIST);
				
			if(!(this.facade as KFacade))
				throw new Error(FacadeErrorConstants.FACADE_IS_NOT_OF_TYPE_KFACADE);
			 
			// Execute groped service call.
			FacadeServiceManager.instance.invokeAMFGroupedServicesCall((this.facade as KFacade).facadeId, 
				serviceRequestGroup.groupKey, 
				serviceRequestGroup.amfServiceRequests, 
				serviceRequestGroup.resultNotificationId, 
				serviceRequestGroup.faultNotificationId, 
				serviceRequestGroup.modalWait, 
				serviceRequestGroup.modalWaitMessage); 
	 
        }*/
    }
}