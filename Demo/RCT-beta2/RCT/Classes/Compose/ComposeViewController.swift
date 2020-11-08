//
//  ComposeViewController.swift
//  XMGWB
//
//  Created by xiaomage on 15/11/16.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit
import AVFoundation
class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK:- 工具栏的按钮
    let toolbarFunction = ["", "camera", "mention", "hottopic", "emoji", "more"]
    @IBAction func toolButtonClick(_ sender: UIButton) {
        // print("CLICK TAG\(sender.tag)")
        
        let functionStr = toolbarFunction[sender.tag]
        switch functionStr {
        case "camera": self.pictureBtnClick()
        default:
            print("功能没完成")
        }
    }
    @IBOutlet weak var bottomToolbar: UIToolbar!
    // MARK:- 属性
    /// 工具条底部约束
    @IBOutlet weak var toolbarBottomCons: NSLayoutConstraint!
    
    /// 自定义TextView
    @IBOutlet weak var customTextView: ComposeTextView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
         let imagePickerc = info[UIImagePickerControllerOriginalImage] as! UIImage
        // cameraView.image.image = imagePickerc
        self.dismiss(animated: true, completion: nil)
       
    }
    // MARK:- 监听按钮的点击
    func pictureBtnClick() {
        //print(pictureBtnClick)
        if #available(iOS 8.0, *) {
            let alertView = UIAlertController()
            alertView.addAction(UIAlertAction(title: "打开相册", style: .default, handler: { (sender) in
                //camera
                let pickerCamera = UIImagePickerController()
                pickerCamera.delegate = self
                self.present(pickerCamera, animated: true, completion: nil)
            }))
            
            alertView.addAction(UIAlertAction(title: "打开相机", style: .default, handler: { (sender) in
                //Photo
                var sourceType = UIImagePickerController().sourceType
                sourceType = .camera
                
//                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
//                    print("无法调用相机")
//                    sourceType = UIImagePickerController.SourceType.photoLibrary //改为调用相册
//                }
                
                
                let pickerPhoto = UIImagePickerController()
                
                pickerPhoto.delegate = self
                
                pickerPhoto.allowsEditing = true//设置可编辑
                
                pickerPhoto.sourceType = sourceType
                
                self.present(pickerPhoto, animated: true, completion: nil)//进入照相界面
                
            }))
            
            alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (sender) in
                //camera
            }))
            self.present(alertView, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
    }
    /* 监听图片按钮的点击
    @IBAction
    /// 监听表情按钮点击
    @IBAction func emoticonBtnClick(sender: AnyObject) {
        print(emoticonBtnClick)
    }
    */
    /// 监听取消按钮的点击
    @objc func cancelBtnClick(sender: AnyObject) {
//        dismiss(animated: true, completion: nil)
        
        dismiss(animated: true) {
            print("compose vc dismiss")
        }
    }
    
    /// 监听发送按钮点击
    @IBAction func sendBtnClick(sender: AnyObject) {
        print(sendBtnClick)
    }
    
    
    
    // MARK:- 系统调用的方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑器"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelBtnClick(sender:)))
        // 1.设置textView代理
        customTextView.delegate = self
        
        // 2.监听键盘变化
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(note:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 召唤键盘
        customTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 注销键盘
        customTextView.resignFirstResponder()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    // MARK: - 内部控制方法
    @objc private func keyboardWillChange(note: NSNotification)
    {
        // 获取键盘弹出和退出的时间
        let durationTime = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        // 获取和底部的差距
        
        
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
        var margin = view.frame.size.height - endFrame.origin.y
        //IPX -34
        if margin>0
        {
          margin = margin-34.0
        }
        // 改变约束,并且执行动画
        toolbarBottomCons.constant = margin
        
        
        
        //toolBarBottomCons.constant = margin
        UIView.animate(withDuration: durationTime) {
        // 如果执行多次动画,则忽略上一次已经未完成的动画,直接进入下一次
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            print(self.bottomToolbar.frame)
            self.view.layoutIfNeeded()
        }
    }

}





extension ComposeViewController: UITextViewDelegate
{
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        customTextView.resignFirstResponder()
    }
}
