//
//  RegisterAgreementCheckView.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/31.
//

import UIKit
import ApplicationKit

class RegisterAgreementCheckView: UIView {

  private let textButton = UIButton(type: .custom)

  var isCheck: Bool { return textButton.isSelected }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Public
extension RegisterAgreementCheckView {

}

// MARK: - Setup
private extension RegisterAgreementCheckView {

  func setupUI() {


    textButton.setTitleColor(Color.textOfLight, for: .normal)
    textButton.titleLabel?.font = Font.pingFangSCMedium(11)
    textButton.setTitle("请阅读并同意", for: .normal)
    textButton.setImage(UIImage(named: "round_dot_stroke_check_normal"), for: .normal)
    textButton.setImage(UIImage(named: "round_dot_stroke_check_selected"), for: .selected)
    textButton.addTarget(self, action: #selector(clickCheck(_:)), for: .touchUpInside)
    textButton.setImage(position: .left, with: 2)
    addSubview(textButton)
    textButton.layout.add { (make) in
      make.top().bottom().leading().equal(self)
    }

//    textLabel.textColor = Color.textOfSilver
//    textLabel.font = Font.pingFangSCRegular(12)
//    addSubview(textLabel)
//    textLabel.layout.add { (make) in
//      make.top().bottom().leading().equal(self)
//    }

    let agreementButton1 = UIButton(type: .custom)
    agreementButton1.titleLabel?.font = Font.pingFangSCRegular(12)
    agreementButton1.setTitleColor(Color.textOfMedium, for: .normal)
    agreementButton1.setTitle("《小桔子家辅用户协议》", for: .normal)
    addSubview(agreementButton1)
    agreementButton1.layout.add { (make) in
      make.top().bottom().equal(self)
      make.leading().equal(textButton).trailing()
    }
    
    let textLabel = UILabel()
    textLabel.text = "和"
    textLabel.font = Font.pingFangSCMedium(11)
    textLabel.textColor = Color.textOfMedium
    addSubview(textLabel)
    textLabel.layout.add { (make) in
      make.top().bottom().equal(self)
      make.leading().equal(agreementButton1).trailing()
    }

    let agreementButton2 = UIButton(type: .custom)
    agreementButton2.titleLabel?.font = Font.pingFangSCRegular(12)
    agreementButton2.setTitleColor(Color.textOfMedium, for: .normal)
    agreementButton2.setTitle("《隐私政策》", for: .normal)
    addSubview(agreementButton2)
    agreementButton2.layout.add { (make) in
      make.top().bottom().trailing().equal(self)
      make.leading().equal(textLabel).trailing()
    }

  }

}

// MARK: - Action
private extension RegisterAgreementCheckView {

  @objc func clickCheck(_ sender: UIButton) {

    textButton.isSelected = !textButton.isSelected

  }

}

