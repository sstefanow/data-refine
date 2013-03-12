Dane na temat wydatków brytyjskiego Home Offce w 2010 roku
=============

##Źródło danych

1) Dane pochodzą ze strony [DataGov](http://data.gov.uk/) .

2) Można je pobrać w formacie .csv z tego [miejsca](http://data.gov.uk/dataset/financial-transactions-data-ho/) . 

##Procedura oczyszczenia danych

1) Pobranie ze strony plików csv z danymi.

2) Import danych do google refine.

3) Oczyszczenie danych. Procedura oczyszczania obejowała między innymi przebudowanie kolumny transakcji, poprawienie formatu danych, eliminację literówek oraz powtórzeń, skorzystanie z funkcji 'reconcile' i 'cluster'. 

## Dane:
```json
    {
      "File" : "refine2.csv",
      "Department family" : "Home Office",
      "Entity" : "Home Office",
      "Date" : "13.05.2010",
      "Expense type" : "Science; Technical & Research.Social Research",
      "Expense area" : "CPG - Crime & Policing Group",
      "Supplier" : "MATRIX RESEARCH AND CONSULTANCY LTD",
      "Transaction number" : 1715492,
      "Transaction code" : "",
      "Amount" : "35 177.15"
    },
    {
      "File" : "refine2.csv",
      "Department family" : "Home Office",
      "Entity" : "Home Office",
      "Date" : "14.05.2010",
      "Expense type" : "Grant",
      "Expense area" : "CPG - Crime & Policing Group",
      "Supplier" : "HAMPSHIRE POLICE AUTHORITY 1 (G)",
      "Transaction number" : 372696,
      "Transaction code" : "",
      "Amount" : "67 571.34"
    },
    {
      "File" : "refine2.csv",
      "Department family" : "Home Office",
      "Entity" : "Home Office",
      "Date" : "14.05.2010",
      "Expense type" : "IT; Broadcasting & Telecomms.IT Run Costs other -Prog",
      "Expense area" : "CPG - Crime & Policing Group",
      "Supplier" : "ALTIUS CONSULTING LTD",
      "Transaction number" : 1673343,
      "Transaction code" : "",
      "Amount" : "30 667.50"
    },
```

## Procedura oczyszczania - 28 kroków:
```json
[
  {
    "op": "core/text-transform",
    "description": "Text transform on cells in column Date using expression grel:value.replace(\"/\", \".\")",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Date",
    "expression": "grel:value.replace(\"/\", \".\")",
    "onError": "keep-original",
    "repeat": false,
    "repeatCount": 10
  },
  {
    "op": "core/text-transform",
    "description": "Text transform on cells in column Amount using expression grel:value.replace(\";\", \" \")",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Amount",
    "expression": "grel:value.replace(\";\", \" \")",
    "onError": "keep-original",
    "repeat": false,
    "repeatCount": 10
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "0"
        ],
        "to": ""
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "CPG - Crime & Policing Group "
        ],
        "to": "CPG - Crime & Policing Group"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "IPCC - Independent Police Complaints Commision"
        ],
        "to": "IPCC - Independent Police Complaints Commission"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "IPS - Identity & Passport Services"
        ],
        "to": "IPS - Identity & Passport Service"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Office services"
        ],
        "to": "Office Services"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Office services "
        ],
        "to": "Office Services "
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Office Services "
        ],
        "to": "Office Services"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "OSCT - Office of Security & Counter Terrorism"
        ],
        "to": "OSCT - Office of Security & Counter-Terrorism"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "OSCT - Office of Security & Counter-Terrorism"
        ],
        "to": "OSCT - Office of Security and Counter-Terrorism"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "PFD*"
        ],
        "to": "PFD"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense area",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense area",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "UKBA - UK Border Agency"
        ],
        "to": "UKBA - UK Borders Agency"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Supplier",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Supplier",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "GLOUCESTERSHIRE POLICE AUTHORITY (",
          "GLOUCESTERSHIRE POLICE AUTHORITY",
          "Gloucestershire Police Authority"
        ],
        "to": "GLOUCESTERSHIRE POLICE AUTHORITY"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "EDF Energy",
          "EDF ENERGY"
        ],
        "to": "EDF Energy"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "THE METROPOLITAN POLICE",
          "The Metropolitan Police"
        ],
        "to": "THE METROPOLITAN POLICE"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Derbyshire Police Authority",
          "DERBYSHIRE POLICE AUTHORITY"
        ],
        "to": "Derbyshire Police Authority"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Durham Police Authority",
          "DURHAM POLICE AUTHORITY"
        ],
        "to": "Durham Police Authority"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "HEALTH MANAGEMENT LTD",
          "Health Management Ltd"
        ],
        "to": "HEALTH MANAGEMENT LTD"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Airwave Solutions Ltd",
          "AIRWAVE SOLUTIONS LTD"
        ],
        "to": "Airwave Solutions Ltd"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "BT Global Services",
          "BT GLOBAL SERVICES"
        ],
        "to": "BT Global Services"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "THAMES VALLEY POLICE AUTHORITY",
          "Thames Valley Police Authority"
        ],
        "to": "THAMES VALLEY POLICE AUTHORITY"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Reed Employment plc",
          "REED EMPLOYMENT PLC"
        ],
        "to": "Reed Employment plc"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Field Fisher Waterhouse LLP",
          "FIELD FISHER WATERHOUSE LLP"
        ],
        "to": "Field Fisher Waterhouse LLP"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "WEST MIDLANDS POLICE",
          "West Midlands Police"
        ],
        "to": "WEST MIDLANDS POLICE"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Lancashire Police Authority",
          "LANCASHIRE POLICE AUTHORITY"
        ],
        "to": "Lancashire Police Authority"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "BT",
          "BT "
        ],
        "to": "BT"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "MANCHESTER AIRPORT PLC",
          "Manchester Airport PLC"
        ],
        "to": "MANCHESTER AIRPORT PLC"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Capita Resourcing Ltd",
          "CAPITA RESOURCING LTD"
        ],
        "to": "Capita Resourcing Ltd"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "CAPITA BUSINESS SERVICES LTD",
          "Capita Business Services Ltd"
        ],
        "to": "CAPITA BUSINESS SERVICES LTD"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "GREATER MANCHESTER POLICE",
          "Greater Manchester Police"
        ],
        "to": "GREATER MANCHESTER POLICE"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "OGC BUYING SOLUTIONS",
          "OGC Buying Solutions"
        ],
        "to": "OGC BUYING SOLUTIONS"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Company Watch Ltd",
          "COMPANY WATCH LTD"
        ],
        "to": "Company Watch Ltd"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "HUMBERSIDE POLICE AUTHORITY",
          "Humberside Police Authority"
        ],
        "to": "HUMBERSIDE POLICE AUTHORITY"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "FCO SERVICES",
          "FCO Services"
        ],
        "to": "FCO SERVICES"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "LEICESTERSHIRE POLICE AUTHORITY (G",
          "LEICESTERSHIRE POLICE AUTHORITY (G)"
        ],
        "to": "LEICESTERSHIRE POLICE AUTHORITY"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "FORENSIC SCIENCE SERVICE",
          "Forensic Science Service"
        ],
        "to": "FORENSIC SCIENCE SERVICE"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Central Office of Information",
          "CENTRAL OFFICE OF INFORMATION"
        ],
        "to": "Central Office of Information"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Atkins Ltd",
          "ATKINS LTD"
        ],
        "to": "Atkins Ltd"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Specialist Computer Centres PLC",
          "SPECIALIST COMPUTER CENTRES PLC"
        ],
        "to": "Specialist Computer Centres PLC"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "PARITY RESOURCES LTD",
          "Parity Resources Ltd"
        ],
        "to": "PARITY RESOURCES LTD"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "LINCOLNSHIRE POLICE AUTHORITY",
          "Lincolnshire Police Authority"
        ],
        "to": "LINCOLNSHIRE POLICE AUTHORITY"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "SIEMENS BUSINESS SERVICES LTD",
          "Siemens Business Services Ltd"
        ],
        "to": "SIEMENS BUSINESS SERVICES LTD"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Logica CMG UK Ltd",
          "LOGICA CMG UK LTD"
        ],
        "to": "Logica CMG UK Ltd"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "AUDIT COMMISSION",
          "Audit Commission"
        ],
        "to": "AUDIT COMMISSION"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "PENNA PLC",
          "Penna PLC"
        ],
        "to": "PENNA PLC"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Cleveland Police Authority",
          "CLEVELAND POLICE AUTHORITY"
        ],
        "to": "Cleveland Police Authority"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "CAPITA BUSINESS TRAVEL",
          "Capita Business Travel"
        ],
        "to": "CAPITA BUSINESS TRAVEL"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "NATIONAL AUDIT OFFICE",
          "National Audit Office"
        ],
        "to": "NATIONAL AUDIT OFFICE"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "MERSEYSIDE POLICE AUTHORITY",
          "Merseyside Police Authority"
        ],
        "to": "MERSEYSIDE POLICE AUTHORITY"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Essex Police Authority",
          "ESSEX POLICE AUTHORITY"
        ],
        "to": "Essex Police Authority"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "SOUTH YORKSHIRE POLICE",
          "South Yorkshire Police"
        ],
        "to": "SOUTH YORKSHIRE POLICE"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "OCS GROUP UK LTD",
          "OCS GROUP UK LTD "
        ],
        "to": "OCS GROUP UK LTD"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Surrey Police Authority",
          "SURREY POLICE AUTHORITY"
        ],
        "to": "Surrey Police Authority"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "British Transport Police",
          "BRITISH TRANSPORT POLICE"
        ],
        "to": "British Transport Police"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Supplier",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Supplier",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "LEICESTERSHIRE POLICE AUTHORITY",
          "Leicestershire Police Authorit"
        ],
        "to": "LEICESTERSHIRE POLICE AUTHORITY"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "NORTHAMPTONSHIRE COUNTY COUNCIL 2",
          "NORTHAMPTONSHIRE COUNTY COUNCIL 1"
        ],
        "to": "NORTHAMPTONSHIRE COUNTY COUNCIL"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "NOTTINGHAMSHIRE POLICE AUTHORITY 2",
          "NOTTINGHAMSHIRE POLICE AUTHORITY 1"
        ],
        "to": "NOTTINGHAMSHIRE POLICE AUTHORITY"
      }
    ]
  },
  {
    "op": "core/text-transform",
    "description": "Text transform on cells in column Transaction number using expression grel:value.replace(\" \", \"\")",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Transaction number",
    "expression": "grel:value.replace(\" \", \"\")",
    "onError": "keep-original",
    "repeat": false,
    "repeatCount": 10
  },
  {
    "op": "core/text-transform",
    "description": "Text transform on cells in column Transaction number using expression value.toNumber()",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Transaction number",
    "expression": "value.toNumber()",
    "onError": "keep-original",
    "repeat": false,
    "repeatCount": 10
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense type",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense type",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Grant",
          "GRANT"
        ],
        "to": "Grant"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Licensing costs",
          "Licensing Costs"
        ],
        "to": "Licensing costs"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Legal costs",
          "Legal Costs "
        ],
        "to": "Legal costs"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Publicity & Advertising",
          "Advertising & Publicity"
        ],
        "to": "Publicity & Advertising"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "IT Services",
          "IT services"
        ],
        "to": "IT Services"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Legal fees",
          "Legal Fees"
        ],
        "to": "Legal fees"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "OGD's; Councils & Police Authorities",
          "OGDs; Councils & Police Authorities"
        ],
        "to": "OGD's; Councils & Police Authorities"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Rent",
          "Rent  "
        ],
        "to": "Rent"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "IT & Telecoms Components.Standard Software (FA)",
          "IT & Telecoms Components.Standard Software  (FA)"
        ],
        "to": "IT & Telecoms Components.Standard Software (FA)"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Audit Fees - external",
          "External Audit Fees"
        ],
        "to": "External Audit Fees"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "IT & Telecoms Components.Computer Equip (FA)",
          "IT & Telecoms Components.Computer Equip  (FA)"
        ],
        "to": "IT & Telecoms Components.Computer Equip (FA)"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense type",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense type",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Adelphi Ongoing Costs",
          "Adelphi ongoing cost"
        ],
        "to": "Adelphi Ongoing Costs"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "CRB Disclosures",
          "CRB Disclosure"
        ],
        "to": "CRB Disclosures"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Law Enforcement & safety Equip.Maint&Rep of Plant&Mach–PROG",
          "Law Enforcement & safety Equip.Maint&Rep of Plant&MachűPROG"
        ],
        "to": "Law Enforcement & safety Equip.Maint&Rep of Plant&Mach–PROG"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "IT; Broadcasting & Telecomms.IT Run Cost ű Info Support",
          "IT; Broadcasting & Telecomms.IT Run Cost – Info Support"
        ],
        "to": "IT; Broadcasting & Telecomms.IT Run Cost – Info Support"
      },
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Professional & Admin Services.SBS PFI ű Infra & Helpdesk",
          "Professional & Admin Services.SBS PFI – Infra & Helpdesk"
        ],
        "to": "Professional & Admin Services.SBS PFI – Infra & Helpdesk"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense type",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense type",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Politics & Civic Affairs.Human aid & relief Sect 4",
          "Politics & Civic Affairs.Human aid & relief Sect 5"
        ],
        "to": "Politics & Civic Affairs.Human aid & relief Sect"
      }
    ]
  },
  {
    "op": "core/mass-edit",
    "description": "Mass edit cells in column Expense type",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Expense type",
    "expression": "value",
    "edits": [
      {
        "fromBlank": false,
        "fromError": false,
        "from": [
          "Politics & Civic Affairs.Human aid & relief Sect 4",
          "Politics & Civic Affairs.Human aid & relief Sect 5"
        ],
        "to": "Politics & Civic Affairs.Human aid & relief Sect"
      }
    ]
  },
  {
    "op": "core/column-addition",
    "description": "Create column Transaction code at index 8 based on column Transaction number using expression grel:if(isNumeric(value), \"\", value)",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "newColumnName": "Transaction code",
    "columnInsertIndex": 8,
    "baseColumnName": "Transaction number",
    "expression": "grel:if(isNumeric(value), \"\", value)",
    "onError": "set-to-blank"
  },
  {
    "op": "core/text-transform",
    "description": "Text transform on cells in column Transaction number using expression grel:if(isNumeric(value), value, \"\")",
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    },
    "columnName": "Transaction number",
    "expression": "grel:if(isNumeric(value), value, \"\")",
    "onError": "keep-original",
    "repeat": false,
    "repeatCount": 10
  },
  {
    "op": "core/recon",
    "description": "Reconcile cells in column Supplier to type /people/person",
    "columnName": "Supplier",
    "config": {
      "mode": "standard-service",
      "service": "http://4.standard-reconcile.dfhuynh.user.dev.freebaseapps.com/reconcile",
      "identifierSpace": "http://rdf.freebase.com/ns/type.object.mid",
      "schemaSpace": "http://rdf.freebase.com/ns/type.object.id",
      "type": {
        "id": "/people/person",
        "name": "/people/person"
      },
      "autoMatch": true,
      "columnDetails": []
    },
    "engineConfig": {
      "facets": [],
      "mode": "row-based"
    }
  },
  {
    "op": "core/column-removal",
    "description": "Remove column Column4",
    "columnName": "Column4"
  },
  {
    "op": "core/column-removal",
    "description": "Remove column Column",
    "columnName": "Column"
  },
  {
    "op": "core/column-removal",
    "description": "Remove column Column2",
    "columnName": "Column2"
  },
  {
    "op": "core/column-removal",
    "description": "Remove column Column3",
    "columnName": "Column3"
  }
]
```
