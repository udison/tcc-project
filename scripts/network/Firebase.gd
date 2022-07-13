extends Node

const API_KEY = 'AIzaSyC8Lc44Uex7vYPJ_qhik4IP9R45POsW7Lc'
const PROJECT_ID = 'cowboy-survival'

const FIRESTORE_URL = 'https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents
' % PROJECT_ID


func get_request_headers(content_length):
	return PackedStringArray([
		"Content-Type: application/json",
		"Content-Length: " + str(content_length)
	])


func submit_score(http: HTTPRequest, name: String, time: float, kills: int):
	var document := {
		"fields": {
			"name": {"stringValue": name},
			"time": {"integerValue": time},
			"kills": {"integerValue": kills},
			"created_at": {"timestampValue": Time.get_datetime_string_from_system() + 'Z'},
			"version": {"stringValue": "1.0-godot"}
		}
	}
	var document_id = (name + str(time) + str(kills)).sha256_text().substr(0, 12)
	var body = JSON.new().stringify(document)
	var url = FIRESTORE_URL + '/scores?documentId=%s' % document_id
	
	http.request(url, get_request_headers(body.length()), false, HTTPClient.METHOD_POST, body)
