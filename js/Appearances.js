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
  appearances: {
    flexDirection: 'row',
  },
  icon: {
    width: 38,
    height: 38,
    margin: 6
  },
});
 
class Appearances extends React.Component {
  _onPress(appearance) {
    if (this.props.appearanceSelectionHandler) {
      this.props.appearanceSelectionHandler(appearance);
    }
  }
 
  render() {
    var appearances = [];
    var imagesSelected = [
      {uri: 'med1-on.png'},
      {uri: 'med2-on.png'},
      {uri: 'med3-on.png'},
      {uri: 'med4-on.png'},
      {uri: 'med5-on.png'},
      {uri: 'med6-on.png'},
      {uri: 'med7-on.png'},
    ];
    var imagesUnselected = [
      {uri: 'med1-off.png'},
      {uri: 'med2-off.png'},
      {uri: 'med3-off.png'},
      {uri: 'med4-off.png'},
      {uri: 'med5-off.png'},
      {uri: 'med6-off.png'},
      {uri: 'med7-off.png'},
    ];
    for (var k = 0; k <= 6; k++) {
      var key = 'appearance-'+k;
      var appearanceImage = (k == this.props.appearance) ?
        <Image style={styles.icon} source={imagesSelected[k]} /> :
        <Image style={styles.icon} source={imagesUnselected[k]} />;
      var appearance =
        <TouchableOpacity key={key} onPress={this._onPress.bind(this, k)}>
          {appearanceImage}
        </TouchableOpacity>;
      appearances.push(appearance);
    }
    return (
      <View style={styles.container}>
        <View style={styles.appearances}>
          {appearances}
        </View>
      </View>
    );
  }
}
 
module.exports = Appearances;