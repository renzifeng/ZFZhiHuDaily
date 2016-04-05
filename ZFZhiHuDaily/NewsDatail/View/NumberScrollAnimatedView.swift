//  数字滚动的View,可以用来当做计数器,倒计时器等等
//  NumberScrollAnimatedView.swift
//  ClickZhanButton
//
//  Created by 任子丰 on 16/1/12.
//  Copyright © 2015年 任子丰. All rights reserved.
//

import UIKit

class NumberScrollAnimatedView: UIView {
    
    var delegate:NumberScrollAnimatedDelegate?
    private var finishAction:(()->Void)?
    
    /// 这个用于记录上一次的值的
    private var lastValue:NSNumber?
    
    /// 记录这个View中的Number的值
    var value:NSNumber! = 0 {
        didSet {
            //使用观察器来记录上一次的值,以及更新View中的Label
            lastValue = oldValue
            self.prepareAnimations()
        }
    }
    //
    /// 用于记录字体的颜色
    var textColor:UIColor!
    
    /// 用于记录字体
    var font:UIFont! {
        didSet {
            //使用观察器来更新字体
            if !font.isEqual(oldValue) {
               //如果是新的值
                //那么久计算出这个字体下,一个字符的宽度
                self.characterWidth = NSString(string: "8").sizeWithAttributes([NSFontAttributeName:font]).width
                
                //遍历所有的Label,把字体给改了
                for value in self.scrollLabels {
                    value.font = font
                }
                
                //更新UI
                self.setNeedsLayout()
                self.invalidateIntrinsicContentSize()
            }
        }
    }
    
    /// 用于记录整个动画的时间的
    var duration:Float = 1
    
    /// 用于记录每一个Label的时间差,这个值的绝对值越大.在动画过程中,多位数中每一位数字的动画时间差别就越大,0表示各位数 同时变动,同时停止
    var durationOffset:Float = 0
    
    /// 表示每一位数字要变动几次 才停下来. 0表示变动1次   -1表示不进行动画,直接变动
    var desity:Int = 0
    
    /// 表示最小的位数, 位数不够就直接补零
    var minLength:Int = 0
    
    /// 表示变动的方向, 是从上而下 还是从下而上
    var isAscending:Bool = false
    
    /// 表示单个字符的宽度
    private var characterWidth:CGFloat!
    
    /// 用于记录字符, Layer Label的 数组
    private var oldNumbersText:[String] = []
    private var numbersText:[String] = []
    private var scrollLayers:[CAScrollLayer] = []
    private var scrollLabels:[UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    private func _init(){
        
        //设置默认的字体和颜色
        self.font = UIFont.systemFontOfSize(UIFont.systemFontSize())
        self.textColor = UIColor.blackColor()
        
    }
    
    /// 表示预准备动画
    private func prepareAnimations(){
        
        //把一切都先还原
        for layer in scrollLayers {
            layer.removeFromSuperlayer()
        }

        numbersText.removeAll()
        oldNumbersText.removeAll()
        scrollLayers.removeAll()
        scrollLabels.removeAll()

        //开始设置新的numbersText
        self.createNumbersText(self.value!,numbersText:&numbersText)
        
        //如果有旧的值,那么就再设置旧的NumbersText
        if let _old = self.lastValue {
            self.createNumbersText(_old, numbersText:&oldNumbersText)
        }
        
        //创建ScrollLayers
        self.createScrollLayers()
    }
    
    /**
    这个是具体的创建NumbersText的逻辑
    
    - parameter value:       新的值
    - parameter numbersText: 返回的每一位数字的数组
    */
    private func createNumbersText(value:NSNumber,inout numbersText:[String]){
       
        //找到数字的字符串
        let textValue = value.stringValue
        
        //如果长度不够就补零
//        for var i = 0; i < self.minLength - textValue.characters.count; i++ {
//            numbersText.append("0")
//        }
        
        //判断是否是有负号
        var minus = false;
        for char in textValue.characters {
            if  "-" == char {
                //如果是负数符号,那么本次循环就不添加字符,否则 光加一个"-" 这个符号,在转换成数字的时候是要出错的
                minus=true
                continue
            }
            
            //如果上一次循环是有负号的,这次就把负号加上
            if minus {
                numbersText.append("-"+String(char))
                minus=false
            } else {
                //否则就直接在数组中添加这次的数字
                numbersText.append(String(char))
            }
            
        }
        
    }
    
    /// 创建ScrollLayers
    private func createScrollLayers(){
        //每一个Layer的宽度就是字符的宽度
        let width = self.characterWidth;
        //高度和view的高度相同
        let height = CGRectGetHeight(self.frame);
        
        //计算View的宽度 以及 整个数字的宽度
        let frameWidth = Float(CGRectGetWidth(self.frame))
        let length = Float(self.characterWidth) * Float(numbersText.count)
        
        //找到起始的横坐标,这个主要是用于居中数字用的
        let offset = roundf((frameWidth - length)/2);
        
        //表示位数是否相同
        let lengthEqual = numbersText.count == oldNumbersText.count
        
        //遍历每一位数字字符串,然后为每一个数字创建Layer
        for (index,value) in numbersText.enumerate() {
            
            let layer = CAScrollLayer()
            
            //设置每一位数字layer的位置和大小
            layer.frame = CGRectMake(CGFloat(roundf(offset+(Float(index) * Float(width)))), 0, width, height)
            
            //加入数组以及View的layer中去
            scrollLayers.append(layer)
            self.layer.addSublayer(layer)
            
            //如果位数都不相同,那么必然要每一位数字进行变化
            if  !lengthEqual {
                createContentForLayer(layer, withNumberText: value)
            }else {
                //如果位数相同,那么就找到相同位数的值是否相同,如果相同就不进行变化
                let oldValue = oldNumbersText[index]
                createContentForLayer(layer, withNumberText: value, andNeedChange: oldValue != value)
            }
            
        }
        
    }
    
    /**
    根据数字和Layer,创建每一个Layer上的Label
    
    - parameter scrollLayer: Layer
    - parameter numberText:  数字
    - parameter needChange:  是否需要跳动动画
    */
    private func createContentForLayer(scrollLayer:CAScrollLayer,withNumberText numberText:String,andNeedChange needChange:Bool = true) {
        //先把这一位的数字转换为Int
        let number = Int(numberText)
        
        //这个就是最后每一位Layer上纵向排列的Label中的值
        var textForScroll:[String] = []
        
        //保留一个新的值,因为动画完成后,最后其实会返回这个值的,所以textForScroll的第一个 一定是最后要显示的数字
        textForScroll.append(numberText)
        
        let off = isAscending ? 1 : -1      //根据渐变的方向来设置偏移量
        
        //根据是否需要变化而设置desity,如果是-1 那么这个值就不会变了
        let desity = needChange ? self.desity : -1
        
        //根据desity,增加适量的动画中间值
        for i in 0 ..< desity+1 {
            textForScroll.append("\((number!+i+off)%10)")
        }
        
        //最后一个就是动画的最后一针,必然也是新的值本身.这样 首尾呼应,才不会感觉动画在跳变
        textForScroll.append(numberText)
        
        var height:CGFloat = 0
        
        //根据text的值,增加Label
        for text in textForScroll {
            //创建Label
            let textLabel = createLabel(text)
            
            //设置Label的值,这里需要注意的是height在不断的变化
            textLabel.frame = CGRectMake(0, height, CGRectGetWidth(scrollLayer.frame), CGRectGetHeight(scrollLayer.frame))
            
            //增加到subPlayer中去
            scrollLayer.addSublayer(textLabel.layer)
            
            scrollLabels.append(textLabel)
            
            //计算新的Y坐标
            height = CGRectGetMaxY(textLabel.frame)
        }
    }
    
    /**
    创建Label的方法
    
    - parameter text: Label的数字
    
    - returns: 生成的UILabel
    */
    private func createLabel(text:String) -> UILabel {
        let view = UILabel()
        
        view.textColor = self.textColor
        view.font = self.font
        view.textAlignment = NSTextAlignment.Center
        
        view.text = text
        
        return view;
    }
    
    /// 这个是用来创建动画的
    private func createAnimations(){

        //首先计算动画的时间
        let duration = self.duration - ( Float(numbersText.count) * self.durationOffset )
        
        //每一位的时间偏移
        var offset:Float = 0;
        
        //开始循环每一位数字的Layer,开始增加动画
        for scrollLayer in scrollLayers {
            //计算出最大的Y坐标偏移量
            let maxY = scrollLayer.sublayers?.last?.frame.origin.y
            
            //创建一个Y坐标移动的动画
            let animation = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
            //设置动画时间
            animation.duration = CFTimeInterval(duration + offset)
            //设置动画是先快后慢
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            animation.delegate = self
            
            //根据方向,设置动画的起始与结束Y坐标
            if  self.isAscending {
                //这个是计算倒数第二个元素的Y坐标,用于起始坐标
                let i = (scrollLayer.sublayers?.count)!-2
                let y = scrollLayer.sublayers?[i].frame.origin.y
                animation.fromValue = NSNumber(float: Float(0-y!))
                //设置Y坐标为0,作为动画的终止坐标
                animation.toValue = NSNumber(float: Float(0))
            }else {
                //取第二个元素的Y坐标,作为起始坐标
                let y = scrollLayer.sublayers?[1].frame.origin.y
                animation.fromValue = NSNumber(float: Float(0-y!))
                //设置最后一个元素的Y坐标,作为动画的终止坐标
                animation.toValue = NSNumber(float: Float(0-maxY!))
            }
            
            //增加动画
            scrollLayer.addAnimation(animation, forKey: "NumberScrollAnimatedView")
            
            offset += self.durationOffset
        }
    }
    
    /**
    开始动画
    
    - parameter finishAction: 完成动画后的执行操作的闭包
    */
    func startAnimation(finishAction:(()->Void)? = nil){
        self.finishAction = finishAction
        self.prepareAnimations()
        self.createAnimations()
    }
    
    /// 结束动画
    func stopAnimation(){
        
        for layer in scrollLayers {
            layer.removeAnimationForKey("NumberScrollAnimatedView")
        }
        
    }
    
    /// 用于记录动画是否全部结束
    private var finishedCount = 0
    
    /**
    动画完成后的回调
    
    - parameter sender: 动画发起方
    - parameter flag:   结束标识
    */
    override func animationDidStop(sender:CAAnimation,finished flag:Bool) {
        finishedCount += 1
        
        if  finishedCount == scrollLayers.count {
            //表示此次动画全部结束
            finishedCount = 0
            
            if let _action = self.finishAction {
                _action()
            }
            
            if let _delegate = delegate {
                _delegate.animationDidFinish()
            }
        }
    }

}

/**
*  动画完成的回调 委托协议
*/
protocol NumberScrollAnimatedDelegate {
    
    /// 动画完成的回调
    func animationDidFinish()
    
}
