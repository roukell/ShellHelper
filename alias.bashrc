alias awsauto='complete -C "/usr/local/bin/aws_completer" aws'
alias argocdui='echo "admin password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)" && (sleep 2 && cmd.exe /c start https://localhost:8080) & kubectl port-forward svc/argocd-server -n argocd 8080:443'
