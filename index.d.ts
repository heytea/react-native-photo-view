import React, { Component } from 'react'

import { StyleProp, ViewStyle } from 'react-native'

interface HeyteaPhotoViewProps {

  // 数据
  data: Array<string>

  // 首次选中
  selectedIndex?: number

  // 单击事件
  onSingleTap?: Function

  style?: StyleProp<ViewStyle>

}

export default class HeyTeaPhotoView extends Component<HeyteaPhotoViewProps, {}> {}