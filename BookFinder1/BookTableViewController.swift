//
//  BookTableViewController.swift
//  BookFinder1
//
//  Created by D7703_15 on 2017. 10. 30..
//  Copyright © 2017년 D7703_15. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController,XMLParserDelegate,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiKey = "12e019b25265e571f9c178f4d9e4540d"
    var item:[String:String] = [:]
    //item이 들어갈 어레이 생성
    var items:[[String:String]] = []
    //foundCharacter 있을때 그앞의 엘리먼트를 식별하기 위함
    var currentElement:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
    }
    
    func search(query:String, pageno:Int){
        //http 는 보안상 안해준다 http 가 되게 하려면 다른 방법이 필요하다
        //result 한번에 받는 갯수
        let str = "https://apis.daum.net/search/book?apikey=\(apiKey)&output=xml&q=\(query)&pageno=\(pageno)&result=20" as NSString
        
        //한글이 퍼센트 로 바뀜
        let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(strURL ?? "url is error")
        
        //언랩핑 옵셔널이기 때문에 닐이 아니면 만듬
        if let strURL = strURL{
            if let url = URL(string:strURL){
                if let parser = XMLParser(contentsOf: url){
                    parser.delegate = self
                    
                    let success = parser.parse()
                    if success {
                        print("parse success")
                        print(items)
                        
                    }else{
                        print("parse fail")
                    }
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        search(query: searchBar.text!, pageno: 1)
    }
    
    //엘리먼트 네임을 저장 - 키로 쓰기 위해서
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        //새로 만들어 줄때(새로 아이템 태그만낫을때 비워줘야한다)
        //딕셔너리 새로 제작
            if currentElement == "item"{
                //새로 초기화
                item = [:]
            }
    }
    //
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //키 밸류
        item[currentElement] = string
    }
    //배열에 집어넣기
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "item"{
                //배열에 집어 넣기
                items.append(item)
            }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
   
 

}
