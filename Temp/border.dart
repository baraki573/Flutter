Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
        left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
        right: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
        bottom: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
      ),
      color: Color(0xFFBFBFBF),
    ),
    child: const Text(
      'OK',
      textAlign: TextAlign.center,
      style: TextStyle(color: Color(0xFF000000))
    ),
)