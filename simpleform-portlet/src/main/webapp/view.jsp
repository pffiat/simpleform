<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://liferay.com/tld/ddm" prefix="liferay-ddm" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>

<portlet:defineObjects />
<liferay-theme:defineObjects/>


Description du probleme.


<portlet:resourceURL id="addPetition" var="addPetitionURL" />


<div id="<portlet:namespace />myToggler">
	<button class="btn btn-lg btn-block btn-primary header toggler-header-collapsed" type="button">Je veux signer la pétition !</button>
	<div name="fm" id="<portlet:namespace />fm" class="content toggler-content-collapsed">
	
		<aui:input name="name">
		</aui:input>
		<aui:input name="firstName">
		</aui:input>
		<aui:input name="email">
		</aui:input>
		<aui:input name="comment" label="Vous pouvez nous faire part de votre opinion :">
		</aui:input>
	
		<button class="btn btn-primary" type="button" name="save" id="<portlet:namespace />save">Je signe la pétition !</button>
			
	</div>
</div>

<div id="<portlet:namespace />aftersubmit" >
</div>

<div id="<portlet:namespace />hiddendata" hidden="true">
	<h4 id="<portlet:namespace />beforeProgressBar"></h4>

	<div class="yui3-widget component progress horizontal" id="<portlet:namespace />myProgressBar"
		style="height: 25px; width:100%;">
		<div style="height: 100%; top: auto;"
			class="progress-content bar yui3-widget-content-expanded"
			id="<portlet:namespace />myInnerProgressBar"></div>
	</div>
	<h4 id="<portlet:namespace />afterProgressBar" style="text-align: right;"></h4>
</div>

<script>
	AUI().use(
	  'aui-toggler', 
	  'aui-base', 
	  'aui-io-request',
	  'node',
	  function(A) {
   	    
	    new A.TogglerDelegate( {
   	        animated: true,
   	        closeAllOnExpand: true,
   	        container: '#<portlet:namespace />myToggler',
   	        content: '.content',
   	        expanded: false,
   	        header: '.header',
   	        transition: {
   	          duration: 0.2,
   	          easing: 'cubic-bezier(0, 0.1, 0, 1)'
   	        }
   	    });

		A.one('#<portlet:namespace />save').on(
	      'click',
	      function() {
		      
			var name = A.one('#<portlet:namespace />name').val();
			var firstName = A.one('#<portlet:namespace />firstName').val();
			var email = A.one('#<portlet:namespace />email').val();
			var comment = A.one('#<portlet:namespace />comment').val();
	        
			var url = '<%= addPetitionURL.toString() %>';

	        A.io.request(
	        	url,
				{
					//data to be sent to server
					data: {
						<portlet:namespace />name: name,
						<portlet:namespace />firstName: firstName,
						<portlet:namespace />email: email,
						<portlet:namespace />comment: comment,
					},
					dataType: 'json',
					
					on: {
						failure: function() {
							alert('failure ');
						},
						
						success: function() {
							var hiddendata = A.one('#<portlet:namespace />hiddendata').getHTML();
							A.one('#<portlet:namespace />aftersubmit').setHTML('<h3>Merci mille fois ' + firstName + ' ' + name + ' pour votre engagement!</h3>' + hiddendata);
							
						}
					}
				}
	        );
	        
	        A.one('#<portlet:namespace />beforeProgressBar').setHTML('70 soutiens');
	        A.one('#<portlet:namespace />afterProgressBar').setHTML('30 restants pour obtenir notre objectif de 100');

	        A.one('#<portlet:namespace />myToggler').setHTML('');   
	        A.one('#<portlet:namespace />myInnerProgressBar').setStyle('width', '70%');         
	      }
	    );
	  }
	);

	
</script>

