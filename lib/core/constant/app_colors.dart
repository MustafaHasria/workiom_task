import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  //* Primary Colors
  static const Color primary = Color(0xFF4E86F7);
  static const Color secondary = Color(0xff49B27C);
  static const Color tertiary = Color(0xFF96D2B5);
  
  //* Surface & Background
  static const Color surface = Colors.white;
  static const Color background = Colors.white;
  
  //* Black & Text Colors
  static const Color black = Colors.black;
  static const Color buttonTextDark = Color(0xFF0E0F12);
  static const Color grayText = Color(0xFF555555);
  static const Color darkGrayText = Color(0xFF373737);
  static const Color dividerGray = Color(0xFFD5D5D5);
  
  //* Button Colors
  static const Color buttonGrayBackground = Color(0xFFF4F4F4);
  static const Color buttonDisabled = Color(0xFFB4B4B4);
  
  //* Password Strength Colors
  static const Color passwordWeak = Color(0xFFF5C044);
  static const Color passwordMedium = Color(0xFFF5C044);
  static const Color passwordStrong = Color(0xFF0D9D57);
  //* Border & Shadow
  static const Color textFiledBorder = Color(0xFFE0E0E0);
  static const Color shadowLight = Color(0x1A000000);
  
  //* Slider & Indicators
  static const Color glassEffect = Color(0x4C717171);
  static const Color inactiveIndicator = Color(0xFFD9D9D9);
  
  //* Catalog & Categories
  static const Color catalogBackground = Color(0xFFF6F6F6);
  static const Color catalogTextColor = Color(0xFF3B3B3B);
  static const Color catalogCardBackground = Color(0xFFF9FAFB);
  static const Color catalogCardShadow = Color(0x338E8E8E);
  static const Color catalogCardTextPrimary = Color(0xFF111111);
  static const Color catalogCardTextSecondary = Color(0x99111111);
  static const Color catalogDividerLight = Color(0x29000000); // black with 16% opacity
  static const Color catalogTabInactive = Color(0xFF838589);
  
  //* Campaign Card
  static const Color campaignCardBackground = Color(0xFFF7F7F7);
  static const Color campaignTitleColor = Color(0xFF292D32);
  
  //* Campaign Page
  static const Color progressBarFilled = Color(0xFF0D9D57);
  static const Color progressBarUnfilled = Color(0xFFE0E0E0);
  static const Color tabActiveIndicator = Color(0xFF0D9D57);
  static const Color tabInactiveColor = Color(0xFF9E9E9E);
  static const Color donationCardShadow = Color(0x190D9D57);
  static const Color dividerColor = Color(0xFFD9D9D9);
  
  //* Bottom Sheet
  static const Color bottomSheetBackground = Color(0xFFF7F7F7);
  static const Color bottomSheetDivider = Color(0xFFC0C0C0);
  
  //* Fast Donate Bottom Sheet
  static const Color dropdownBackground = Color(0xFFF2F2F2);
  static const Color chipBorderInactive = Color(0xFFD9D9D9);
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
  static const Color textOnPrimary = Colors.white;
  static const Color fieldDivider = Color(0xFFE4E4E4);
  static const Color hintTextColor = Color(0xFFD0D0D0);
  
  //* Action Buttons (Share & Favorite)
  static const Color actionButtonBackground = Color(0x19047D3F); // Semi-transparent green
  static const Color actionButtonIcon = Color(0xFF047D3F); // Solid green
  static const Color favoriteActiveBackground = Color(0x19FF3F3F); // Semi-transparent red
  static const Color favoriteActiveIcon = Color(0xFFFF3F3F); // Solid red
}