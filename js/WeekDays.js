'use strict';
 
import React from 'react';
import ReactNative, {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
} from 'react-native';
 
const styles = StyleSheet.create({
  container: {
    backgroundColor: 'white',
  },
  instructions: {
    color: 'black',
  },
  weekDays: {
    flexDirection: 'row',
  },
  icon: {
    width: 38,
    height: 38,
    margin: 6
  },
  textOn:{
    color: 'white',
    fontSize: 22,
    marginTop: 5,
    textAlign: 'center',
    backgroundColor: 'rgba(0,0,0,0)',
  },
  textOff:{
    color: 'black',
    fontSize: 22,
    marginTop: 5,
    textAlign: 'center',
    backgroundColor: 'rgba(0,0,0,0)',
  }
});
 
class WeekDays extends React.Component {
  _onPress(weekDay) {
    if (this.props.weekDaySelectionHandler) {
      this.props.weekDaySelectionHandler(weekDay);
    }
  }
 
  render() {
    var weekDays = [];
    var dayLetters = [
      'S', 'M', 'T', 'W', 'T', 'F', 'S',
    ];
    for (var k = 0; k <= 6; k++) {
      var key = 'weekDay-'+k;
      var weekDayImage = (k == this.props.weekDay) ?
        <Image 
          style={styles.icon} 
          source={require('./images/day-on.png')}>
            <Text style={styles.textOn}>{dayLetters[k]}</Text>
        </Image> :
        <Image 
          style={styles.icon} 
          source={require('./images/day-off.png')}>
            <Text style={styles.textOff}>{dayLetters[k]}</Text>
        </Image>
      var weekDay =
        <TouchableOpacity key={key} onPress={this._onPress.bind(this, k)}>
          {weekDayImage}
        </TouchableOpacity>;
      weekDays.push(weekDay);
    }

    return (
      <View style={styles.container}>
        <View style={styles.weekDays}>
          {weekDays}
        </View>
      </View>
    );
  }
}
 
module.exports = WeekDays;