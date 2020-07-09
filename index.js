import { NativeModules, requireNativeComponent } from 'react-native';

import React, { Component} from 'react';

var HTPhotoView = requireNativeComponent('HeyteaPhotoView', HeyteaPhotoView)

export default class HeyteaPhotoView extends Component{
  render() {
    return <HTPhotoView {...this.props}/>
  }
}









