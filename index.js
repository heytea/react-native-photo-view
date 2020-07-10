import { NativeModules, requireNativeComponent } from 'react-native';

import React, { Component} from 'react';

var HTPhotoView = requireNativeComponent('HeyteaPhotoView', HeyPhotoView)

export default class HeyPhotoView extends Component{
  render() {
    return <HTPhotoView {...this.props}/>
  }
}

