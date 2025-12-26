import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  String language = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("Appearance"),
          _settingsCard(
            child: Row(
              children: [
                const Icon(Icons.dark_mode_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Dark Mode",
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
                Switch(
                  value: isDark,
                  activeColor: const Color(0xFF8B7CF6),
                  onChanged: (v) {
                    setState(() => isDark = v);

                    /// لاحقًا تربطها بـ theme cubit أو provider أو shared pref
                  },
                )
              ],
            ),
          ),

          const SizedBox(height: 14),

          _sectionTitle("Language"),
          _settingsCard(
            child: Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "App Language",
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
                DropdownButton<String>(
                  value: language,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                        value: "English", child: Text("English")),
                    DropdownMenuItem(
                        value: "Arabic", child: Text("العربية")),
                  ],
                  onChanged: (value) {
                    setState(() => language = value!);

                    /// هنا لاحقًا تضيف:
                    /// context.setLocale(Locale('ar'))
                    /// او
                    /// context.setLocale(Locale('en'))
                  },
                )
              ],
            ),
          ),

          const SizedBox(height: 14),

          _sectionTitle("About"),
          _settingsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Habit Tracker App",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Version 1.0.0",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Built with Flutter 💙",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _settingsCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}
