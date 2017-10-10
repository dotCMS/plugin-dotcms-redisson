<%@page import="com.dotmarketing.util.UtilMethods"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.liferay.portal.model.User"%>
<%@ page import="com.codahale.metrics.Meter" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.dotmarketing.business.CacheLocator" %>
<%@ page import="com.dotmarketing.business.cache.provider.redis.RedissonProProvider" %>
<div>
    <%
        User user= com.liferay.portal.util.PortalUtil.getUser(request);
        boolean hasAdminRole = com.dotmarketing.business.APILocator.getRoleAPI().doesUserHaveRole(user,com.dotmarketing.business.APILocator.getRoleAPI().loadCMSAdminRole());
        if(hasAdminRole){
            Map<String, Meter> meters = RedissonProProvider.getMetrics();
            for (String mKey : meters.keySet()) {
                Meter meter = meters.get(mKey);
    %>
    <div><%=mKey%> : <%=meter.getCount()%></div>
    <%
        }
    %>
</div>
<%
}else{
%>
<html>
<head></head>
<body>You don't have the necessary permissions to run this script!</body>
</html>
<%
    }
%>



