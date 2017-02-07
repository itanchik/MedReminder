var React = require('react');
import PushNotification from 'react-native-push-notification';

var {
    Component
   } = React;
 

export default class PushController extends Component {
  
  componentDidMount(){
  	PushNotification.configure({
		onRegister: function(token) {
			console.log( 'TOKEN:', token );
		},
  		onNotification: function(notification){
  			console.log('NOTIFICATION:', notification);
  		},
  		permissions: {
  			alert: true,
  			badge: true,
  			sound: true
    	},
    	popInitialNotification: true,
		requestPermissions: true,
  	});
  }
  


    render() {
		return null;
    }
}

module.exports = PushController;