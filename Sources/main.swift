import InterchangeVoc
import Vocabulaire
import JSONMediaType
import File

extension ForeignLexeme {
	public init(lemma: Morpheme, forms: [Morpheme], origin: Morpheme, meaning: String, permissibility: Permissibility) {
		self.lemma = lemma
		self.forms = forms
		self.origin = origin
		self.meaning = meaning
		self.permissibility = permissibility
	}
}

let manager: Morpheme = "Менеджер"
let managerOrigin: Morpheme = "Manager"
let managerForms: [Morpheme] = ["Менеджмент", "Менеджуля"]
let managerMeaning = "Человек, занимающий руководящую должность"

let managerForeignLexeme = ForeignLexeme(
	lemma: manager,
	forms: managerForms,
	origin: managerOrigin,
	meaning: managerMeaning,
	permissibility: .NotAllowed
)

extension NativeLexeme {
	public init(lemma: Morpheme, meaning: String, usage: Usage) {
		self.lemma = lemma
		self.meaning = meaning
		self.usage = usage
	}
}

let uprav: Morpheme = "Управляющий"
let upravMeaning = "Человек, управляющий процессами"
let upravNativeLexeme = NativeLexeme(lemma: uprav, meaning: upravMeaning, usage: .General)

let rukov: Morpheme = "Руководитель"
let rukovMeaning = "Человек, занимающий руководящую должность"
let rukovNativeLexeme = NativeLexeme(lemma: rukov, meaning: rukovMeaning, usage: .General)

extension User {
	public init(id: Int, username: String, status: Status = .Regular) {
		self.id = id
		self.username = username
		self.status = status
	}	
}

let flo = User(id: 2016, username: "flo", status: .BoardMember)

let managerEntry = Entry(id: 1, foreign: managerForeignLexeme, natives: [upravNativeLexeme, rukovNativeLexeme], author: flo)

// print(managerEntry.interchangeData)

let serializer = JSONMediaType().serializer!
let managerData = try! serializer.serialize(managerEntry.interchangeData)

let entryJson = try! File(path: try! File.workingDirectory() + "/entry.json", mode: .TruncateReadWrite)
print(managerData)
try! entryJson.write(managerData)
print(entryJson.path!)
print("Success")