//
//  ViewController.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableview   : UITableView!
    
    //MARK: -  STORED PROPERTIES
    
    var categories = [Category]()
    var dataSource =  [String]()
    var todos = [Todo]()
    let searchController = UISearchController(searchResultsController: nil)
//    var filterTitle: [Todo] = []
    
    //MARK: -  CLASS REFERENCES
    
    var dataViewModel = Injection.provide.CategoryViewModelInjection()
    var todoViewModel = Injection.provide.TodoViewModelInjection()
    
    //MARK: -  LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        configureTableViewCell()
        navBarConfiguration()
        configSearchBar()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        setCategories()
        setTodos()
        tableview.reloadData()
    }
    
//        @IBAction func addCategory(_ sender: Any) {
//            let vc = (self.storyboard?.instantiateViewController(identifier: "CategoryViewController"))! as CategoryViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
}


//MARK: -  VIEW CONTROLLER EXTENSION

extension ViewController{
    //MARK: -  FUNCTIONS
    
    func setCategories(){
        dataViewModel.getAllCategories { allCategories in
            self.categories = allCategories
            allCategories.forEach {
                self.dataSource.append($0.categoryTitle)
            }
            
        }
    }
    
    func setTodos(){
        todoViewModel.getAllTodos { result in
            switch result{
            case .success(let todos):
                self.todos = todos
                print(todos)
//                self.filterTitle = todos
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func configSearchBar(){
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter name to search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
//        searchController.searchBar.delegate = self
    }
    
    func navBarConfiguration()  {
        //navbar buttons
        let config = UIImage.SymbolConfiguration(
            pointSize: 32, weight: .medium, scale: .default)
        let rightBarBtnIcon = UIImage(systemName: "plus", withConfiguration: config)
        let rightBarBtn = UIButton(type: .custom)
        rightBarBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightBarBtn.setImage(rightBarBtnIcon, for: .normal)
        rightBarBtn.addTarget(self, action: #selector(addTodo(sender:)), for: .touchUpInside)
        let rightBarBtnItem = UIBarButtonItem(customView: rightBarBtn)
        rightBarBtnItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        let currWidth = rightBarBtnItem.customView?.widthAnchor.constraint(equalToConstant: 44)
        currWidth?.isActive = true
        let currHeight = rightBarBtnItem.customView?.heightAnchor.constraint(equalToConstant: 44)
        currHeight?.isActive = true
        navigationItem.setRightBarButton(rightBarBtnItem, animated: true)
        
        //large title
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableViewCell(){
        let tabelViewCell = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableview.register(tabelViewCell, forCellReuseIdentifier: "TableViewCell")
        self.tableview.estimatedRowHeight = 70;
    }
    
    @objc func addTodo(sender: UIBarButtonItem!) {
        self.showPopup(dataSource: dataSource, title: "Add", saveBtnTitle: "Add", placeHolder: "Add Title", actionType: .add, onSubmitBlock: { textFieldValue , indexOfCategory in
            let todoInstance = Todo(id: UUID(), todoTitle: textFieldValue, isChecked: false, todoCategory: self.categories[indexOfCategory])
            self.todoViewModel.createTodo(todo: todoInstance) { result in
                switch result{
                case .success(_):
                    self.dismiss(animated: true) {
                        self.setTodos()
                        self.tableview.reloadData()
//                        self.tableview.reloadSections(IndexSet.init(integer: indexOfCategory), with: .automatic)
                        print("Todo Added Successfully")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
           
        }, onCancelBlock: {
            print("Dismiss No Action performed")
        })
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer?)
    {
//                guard let section = sender?.view?.tag else { return }
        //        dataViewModel.deleteCategory(category: categories[section]) { value in
        //            if value{
        //                self.setCategories()
        //                self.tableview.reloadData()
        //            }
        //        }
//
//                let vc = self.storyboard?.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
//                vc.category = categories[section]
//                self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK: -  VIEW CONTROLLER TABLE VIEW DELEGATES & DATA SOURCE
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredTodos = todos.filter({ $0.todoCategory == categories[section] })
        return filteredTodos.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].categoryTitle
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let filteredTodos = todos.filter({ $0.todoCategory == categories[indexPath.section] })
        cell.config(todo: filteredTodos[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (contextualAction, view, actionPerformed: (Bool) -> ()) in
            
            let filteredTodos = todos.filter({ $0.todoCategory == categories[indexPath.section] })
            
            self.todoViewModel.deleteTodo(todo: filteredTodos[indexPath.row], completion: { value in
                if value {
                    self.setTodos()
                    //                    self.setCategories()
//                    self.tableview.reloadSections(IndexSet.init(integer: indexPath.section), with: .automatic)
                    self.tableview.reloadData()
                }
            })
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let filteredTodo = todos.filter({ $0.todoCategory == categories[indexPath.section] })
        let todo = filteredTodo[indexPath.row]
        
//        let indexValue = IndexPath(item: indexPath.row, section: indexPath.section)
        
        let edit = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.showPopup(dataSource: self.dataSource, title: "Edit", saveBtnTitle: "Edit", placeHolder: "Edit the title", textfieldValue: todo.todoTitle, actionType: .update, pickerIndex: indexPath.section) { textFieldValue, indexOfCategory in
                if self.categories[indexOfCategory] == todo.todoCategory{
                    let todoInstance = Todo(id: todo.id, todoTitle: textFieldValue, isChecked: todo.isChecked, todoCategory: todo.todoCategory)
                    self.todoViewModel.updateTodo(todo: todo, completion: {result in
                        print(todoInstance)
                    })
                }
               
                
            } onCancelBlock: {
                print("cancel tapped")
            }
            
            
        }
        edit.backgroundColor = UIColor.blue
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    
    //Add animation in tableView rows
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//        cell.layer.transform = rotationTransform
//        UIView.animate(withDuration: 1) {
//            cell.layer.transform = CATransform3DIdentity
//        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        headerView.headerTitle?.text = categories[section].categoryTitle
        headerView.backView?.layer.cornerRadius = 10
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        headerView.backView.tag = section
        headerView.backView.addGestureRecognizer(tapRecognizer)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Filteredtodos = todos.filter({ $0.todoCategory.id == categories[indexPath.section].id })
        let todo = Filteredtodos[indexPath.row]
        var isCheck = false
        if todo.isChecked == isCheck{
            isCheck = true
        }
        else{
            isCheck = false
        }
        //indexPath have exact seleted row of tableview that you clicked
        let indexValue = IndexPath(item: indexPath.row, section: indexPath.section)
        print(indexValue)
        todoViewModel.updateTodo(todo: Todo(id: todo.id, todoTitle: (todo.todoTitle), isChecked: isCheck, todoCategory: (todo.todoCategory))) { result in
            self.setTodos()
            tableView.reloadRows(at: [indexValue], with: .automatic)
            print(todo)
        }
    }
}



//extension ViewController: UISearchResultsUpdating, UISearchBarDelegate{
//    func updateSearchResults(for searchController: UISearchController) {
//
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterTitle = []
//        if searchText == ""{
//            filterTitle = todos
//        }
//        for name in todos{
//            if name.todoTitle.lowercased().contains(searchText.lowercased()){
//                filterTitle.append(name)
//            }
//        }
//        print(filterTitle)
//        self.tableview.reloadData()
//    }
//}
