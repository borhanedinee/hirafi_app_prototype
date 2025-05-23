import 'package:flutter/material.dart';
import 'package:hirafi/main.dart';
import 'package:hirafi/models/user_model.dart';
import 'package:hirafi/presentation/screens/messages_screen.dart';
import 'package:hirafi/core/themes/app_colors.dart'; // Assuming AppColors is defined

class ConversationCard extends StatelessWidget {
  final String timestamp;
  final String messagePreview;
  final String category;
  final int unreadCount;
  final VoidCallback? onTap;

  final UserModel userToText;

  final bool isToTextArtisan;

  const ConversationCard({
    super.key,
    required this.timestamp,
    required this.messagePreview,
    required this.category,
    required this.unreadCount,
    this.onTap,
    required this.userToText,
    required this.isToTextArtisan,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MessagesScreen(
              isToTextArtisan: isToTextArtisan,
              userToText: userToText,
              timestamp: timestamp,
              messagePreview: messagePreview,
              category: category,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.greyColor.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Avatar
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  userToText.profileImage!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Main Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name and Timestamp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userToText.name,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        timestamp,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.greyColor,
                            fontStyle: FontStyle.italic,
                            fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Message Preview
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width - 160,
                        child: Text(
                          messagePreview,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.greyColor,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // arrow forward icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColor,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Category and Unread Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
