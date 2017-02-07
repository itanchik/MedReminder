'use strict';

import React from 'react';
import ReactNative, {
  StyleSheet,
  Text,
  View,
  TextInput,
  AppState,
  DatePickerIOS,
  Navigator,
  TouchableOpacity,
  NativeModules,
  NativeEventEmitter,
} from 'react-native';
import PushController from './PushController';
import PushNotification from 'react-native-push-notification';
var moment = require('moment');
const { NewReminderManager } = NativeModules;
const Appearances = require('./Appearances');
const WeekDays = require('./WeekDays');

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    marginTop: 75,
    left:15,
    right:15,
  },
  title: {
    marginTop: 15,
    fontSize: 16,
    color: 'dimgray',
  },
  value: {
    fontSize: 20,
    color: '#F4005E',
    height: 40,
  },
  doneButton: {
    fontSize: 20,
    color: 'white',
  },
  navBar: {
    backgroundColor: '#F4005E',
  },
  navBarText: {
    fontSize: 16,
    marginVertical: 10,
  },
  navBarTitleText: {
    fontSize: 22,
    color: 'white',
    fontWeight: 'bold',
    marginVertical: 9,
  },
  navBarLeftButton: {
    paddingLeft: 10,
  },
  navBarRightButton: {
    paddingRight: 10,
  },
  navBarButtonText: {
    color: 'white',
  },
});

export default class NewReminderView extends React.Component {
	constructor(props) {
    super(props);
    this.sendPush = this.sendPush.bind(this);
    this._subscription = null;
    this.state = {
      identifier: props.identifier,
      currentAppearance: props.currentAppearance,
      currentDays: props.currentDays,
      currentTitle: props.currentTitle,
      currentTime: new Date(),
      currentDosage: props.currentDosage,
      showDatePicker: false
    }
  };
  
  componentDidMount() {
    const NewReminderManagerEvent = new NativeEventEmitter(NewReminderManager);
    this._subscription = NewReminderManagerEvent.addListener(
      'NewReminderManagerEvent',
      (info) => {
        console.log(JSON.stringify(info));
      }
    );
    AppState.addEventListener('change', this.handleAppStateChange);
  }
  
  componentWillUnmount(){
    this._subscription.remove();
  	AppState.removeEventListener('change', this.handleAppStateChange);
  }

  handleAppStateChange(appState){
  	if(appState == 'background'){
    		var date = new Date(Date.now() + (this.state.currentTime.getTime() * 1000));
    		date = date.toISOString();
  	    PushNotification.localNotificationSchedule({
  	    	message: "You should to take some meds",
  	    	date: date,
  	    });
  	  }
  }

  sendPush(entry) {
    this.props.navigator.pop({
      title: 'MED REMINDER',
      passProps: {
        entry: entry
      }
    });
  }

  onAppearanceSelected(selectedAppearance) {
    this.setState({
      currentAppearance: selectedAppearance,
    });
  }

  onWeekDaysSelected(selectedDays) {
    this.setState({
      currentDays: selectedDays,
    });
  }

  setName(selectedTitle){
    this.setState({
      currentTitle: selectedTitle,
    });
  }

  setDosage(selectedDosage){
    this.setState({
      currentDosage: selectedDosage,
    });
  }

  setDate(selectedDate){
    this.setState({
      currentTime: selectedDate,
    });
  }

  _renderScene(route, navigator) {
    var showDatePicker = this.state.showDatePicker ?
        <DatePickerIOS
            style={{ height: 150 }}
            date={this.state.currentTime} 
            minuteInterval={10}
            onDateChange={(date)=>this.setDate(date)}
            mode="time"/> : <View />
    return (
      <View style={styles.content}
            title={route.title}
        navigator={navigator}>
          <Text style = {styles.title}>Med Name</Text>
          <TextInput
              style={styles.value}
              onChangeText={(text) => this.setName(text)}
              value={this.state.text}
          />
          <Text style = {styles.title}>Dosage</Text>
          <TextInput
              style={styles.value}
              onChangeText={(text) => this.setDosage(text)}
              value={this.state.text}
              keyboardType= 'numeric'
          />
          <Text style = {styles.title}>Appearance</Text>
          <Appearances
              appearance={this.state.currentAppearance}
              appearanceSelectionHandler={this.onAppearanceSelected.bind(this)}
          />
          <Text style = {styles.title}>Which Days?</Text>
          <WeekDays
              weekDay={this.state.currentDays}
              weekDaySelectionHandler={this.onWeekDaysSelected.bind(this)}
          />
          <Text style = {styles.title}>When?</Text>
          <TouchableOpacity style={{marginTop: 10, height: 20, width: 300}}
                            onPress={() => this.setState({showDatePicker: !this.state.showDatePicker})}>
              <Text style={styles.value}>{moment(this.state.currentTime).format('HH:mm')}</Text>
          </TouchableOpacity>
          {showDatePicker}
          <PushController/> 
      </View>
    );
  }

  _renderNavTitle(route, navigator, index, navState) {
    return <Text style={styles.navBarTitleText}>{route.title}</Text>;
  }

  _renderNavLeftItem(route, navigator, index, navState) {
    return (
      <TouchableOpacity
        onPress={() => {
          NewReminderManager.dismissPresentedViewController(this.props.rootTag);
        }}
        style={styles.navBarLeftButton}>
        <Text style={[styles.navBarText, styles.navBarButtonText]}>
          Cancel
        </Text>
      </TouchableOpacity>
    );
  }

  _renderNavRightItem(route, navigator, index, navState) {
    if ( this.state.currentAppearance < 7 && this.state.currentDays < 7 && this.state.currentTitle != ''
      && this.state.currentDosage != '') {
      return (
        <TouchableOpacity
          onPress={() => {
            NewReminderManager.save(
              this.props.rootTag,
              this.state.currentTitle,
              moment(this.state.currentTime).format('HH:mm'),
              this.state.currentDosage,
              this.state.currentAppearance,
              this.state.currentDays,
              this.state.identifier
            );
          }}
          style={styles.navBarRightButton}>
          <Text style={[styles.navBarText, styles.navBarButtonText]}>
            Done
          </Text>
        </TouchableOpacity>
      );
    }
    return null;
  }

  render() {
		return (
      <Navigator
        debugOverlay={false}
        style={styles.container}
        initialRoute={{title: 'NEW MED REMINDER'}}
        renderScene={this._renderScene.bind(this)}
        navigationBar={
          <Navigator.NavigationBar
            routeMapper={{
              LeftButton: this._renderNavLeftItem.bind(this),
              RightButton: this._renderNavRightItem.bind(this),
              Title: this._renderNavTitle.bind(this),
            }}
            style={styles.navBar}
          />
        }
      />        
      );
    }
}

module.exports = NewReminderView;
